//
//  HomeViewController.swift
//  TaskHero
//

import UIKit

/*
 HomeViewController is the first tab in the tabbar. It is a tableView that consists of a ProfileHeaderCell at indexPath.row 0
 All other cells are of type TaskCell
 */

final class HomeViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var homeViewModel: HomeViewModel {
        didSet {
            print("\(homeViewModel.taskList)")
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
    
    
    /* Registers cells to tableview, sets background color for view, sets picker delegate to self(HomeViewController), extends layout to start 
       below navbar, adds button items to navcontroller navbar
     
       -- called in viewDidLoad
    */
    
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
        homeViewModel.fetchTasks(tableView: tableView)
        super.viewWillAppear(false)
    }
    
    /* Removes reference to database - necessary to prevent
     * duplicate task cells from loading when viewWillAppear is called again.
       
       -- Functionality implemented in helper class
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        helpers.removeRefHandle()
    }
}

extension HomeViewController: UITextViewDelegate {
    
    // MARK: - UITableViewController Methods
    
    /* Returns number of rows from view model based on task count in currentUser */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows
    }
    
    /* Gets rowheight from view model and returns it - rowheight is UITableViewAutomaticDimension */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeViewModel.rowHeight
    }
    
    // MARK: - Return cells for index - dequeueReusableCell
    
    /* If first row returns profile headerCell else returns taskCell
     all cells configured within HomeViewController using setupCell methods  */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType: HomeCellType = indexPath.row > 0 ? .task : .header
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

// MARK: - Extension for setting up cells & TaskCell delegate logic implementation

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
    
    // MARK: - Delete Task logic
    
    /* Cannot edit cell at tableview index row 0 */
    
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
    
    /* Sets up logoutButtonPressed() , addTaskButtonTapped() selector methods */
    
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
    
    // MARK:  TaskCell Delegate Methods
    
    /* Methods for toggling taskCell edit state. */
    
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
        let tapIndex = tableView.indexPathForRow(at: tapLocation)
        if let index = tapIndex {
            taskMethods.tapEdit(viewController: self, tableView: tableView, atIndex:index, type: .home)
        }
    }
}

// MARK: - ProfileHeaderCell Delegate Method

extension HomeViewController: ProfileHeaderCellDelegate {
    
    internal func profilePictureTapped(sender: UIGestureRecognizer) {
        // need to be implemented
        print("here")
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
