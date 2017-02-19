//
//  HomeViewController.swift
//  TaskHero
//

import UIKit

/*
 HomeViewController is the first tab in the Bar. It is a tableView that consists of a ProfileHeaderCell at indexPath.row 0
 All other cells are of type TaskCell behavior is is currently being abstracted out HomeViewController to HomeViewControllerDataSource
 Not final setup - still a work in progress
 */

final class HomeViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var homeViewModel: HomeViewModel {
        didSet {
            print("HomeViewModel")
        }
    }
    var taskMethods = SharedTaskMethods()
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)
    let photoPopover = PhotoPickerPopover()
    let picker = UIImagePickerController()
    let helpers = Helpers()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
      
    }
    
    /* Before view appears fetches tasks user data using helpers.getData method then for current user
     if currentUser.tasks is not nil, it removes tasks from currentUser regardless it then fetches
     currentUser from database calling APIClient before loading. Redundant functionality,
     definitely could be streamlined */
    
    func viewSetup() {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        taskMethods.setupTableView(tableView: tableView, view: view)
        picker.delegate = self
        edgesForExtendedLayout = []
        addNavItemsToController()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init(_ coder: NSCoder? = nil) {
        self.homeViewModel = HomeViewModel()
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewModel.fetchTasks(tableView: self.tableView)
        super.viewWillAppear(false)
    }
    
    /* Removes reference to database - necessary to prevent
     * duplicate task cells from loading when view will
     * appears is called again. Called inside helpers class
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        helpers.removeRefHandle()
    }
}

extension HomeViewController: UITextViewDelegate {
    
    // MARK: - UITableViewController Methods
    /* Returns number of rows based on count taskcount */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows
    }
    
    /* Gets rowheight from datasource and returns it - rowheight is UITableViewAutomaticDimension */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeViewModel.rowHeight
    }
}

// MARK: - ProfileHeaderCell Delegate Method

extension HomeViewController: ProfileHeaderCellDelegate {
    
    // MARK: - Header cell Delegate Methods
    
    internal func profilePictureTapped(sender: UIGestureRecognizer) {
        print("here")
    }
    
    // MARK: - Return cells Dequeue Method
    /* If first row returns profile header cell else returns task cell all cells configured within HomeViewController  */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType: HomeCellType = indexPath.row > 0 ? .task : .header
        if homeViewModel.taskList.count <= 0 {
            cellType = .header
        }
        switch cellType {
        case .task:
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath) as! TaskCell
            setupTaskCell(taskCell: taskCell, taskIndex: indexPath.row)
            taskCell.delegate = self
            return taskCell
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath) as! ProfileHeaderCell
            setupHeaderCell(headerCell: headerCell, indexPath: indexPath)
            headerCell.delegate = self
            return headerCell
        }
    }
}

// MARK: - Setup Cells Methods

extension HomeViewController: TaskCellDelegate {
    
    func setupHeaderCell(headerCell: ProfileHeaderCell, indexPath: IndexPath) {
        headerCell.emailLabel.isHidden = true
        if let user = homeViewModel.user {
            headerCell.configureCell(user: user)
        }
    }
    
    func setupTaskCell(taskCell:TaskCell, taskIndex: Int) {
        let taskViewModel = homeViewModel.getViewModelForTask(taskIndex: taskIndex)
        taskCell.configureCell(taskVM: taskViewModel)
        let tap = UIGestureRecognizer(target:self, action: #selector(toggleForEditState(_:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.tag = taskIndex
    }
    
    // MARK: - Deletes Tasks logic
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let editable: Bool = indexPath.row == 0 ? false : true
        return editable
    }
    
    /* Logic for deleting tasks from database when user deletes tableview cell */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            backgroundQueue.async {
                self.taskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView, type: .home)
                self.homeViewModel.fetchTasks(tableView: self.tableView)
            }
            tableView.endUpdates()
        }
    }
    
    // MARK: Selector Methods
    /* Sets up action for logout button press, add task button press and adds these as selectors on navigation items which are added to navigation controller. Logs out user by settings root ViewController to Loginview */
    
    func logoutButtonPressed() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.synchronize()
        let loginVC = AppScreenViewController()
        let rootNC = UINavigationController(rootViewController:loginVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootNC
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    // MARK: - Nav Items
    /* Adds two methods above to as selector methods in navigation items and adds navigation items to navigation controller */
    
    func addNavItemsToController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    // MARK: - Popover Methods
    /* Hides popover view when operation has ended. */
    
    internal func hidePopoverView() {
        photoPopover.hidePopView(viewController: self)
    }
    
    // MARK: - Toggle state methods
    /* Task cell Delegate Methods - Mainly toggling UI for edit state
     Method toggles UI states from editing to not editing when save is pressed */
    
    func toggleForButtonState(_ sender:UIButton) {
        let superview = sender.superview
        let cell = superview?.superview as! TaskCell
        let indexPath = tableView.indexPath(for: cell)
        if let index = indexPath {
            taskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: index, type: .home)
        }
    }
    
    /* Kicks off cycling between taskcell editing states */
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        taskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: tapIndex, type: .home)
    }
}

// Extension for header cell delegate methods and UIImagePicker implementation - mainly for ProfilePicture
extension HomeViewController: UIImagePickerControllerDelegate {
    
    // FIXME: - Fix so that image picker can be dismissed by clicking on popover containerview - Add profile picture storage methods
    
    func selectImage(picker:UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    internal func tapPickPhoto(_ sender:UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        photoPopover.hideView(viewController: self)
    }
}
