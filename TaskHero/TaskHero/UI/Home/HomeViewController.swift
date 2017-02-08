//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

/*
 HomeViewController is the first tab in the Bar. It is a tableView that consists of a ProfileHeaderCell at indexPath.row 0
 All other cells are of type TaskCell behavior is is currently being abstracted out HomeViewController to HomeViewControllerDataSource
 Not final setup - still a work in progress
 */

final class HomeViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Deallocate HomeViewController From Memory
    
    deinit {
        print("HomeViewController deallocated")
    }
    
    var store = UserDataStore.sharedInstance
    
    var tasks: [Task] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Internal Properties
    
    let homeViewModel = HomeViewModel()
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)  /* BackgroundQueue for background network */
    var dataSource: HomeViewControllerDataSource!     /* Abstraction of tableView configuration methods */
    let photoPopover = PhotoPickerPopover()      /* Custom Alert/Popover view used for picking profile photo on profilePicture tap */
    let picker = UIImagePickerController()      /* Used to pick profile picture in photoPopover */
    let helpers = Helpers()     /* Helper methods mainly for configuring */
    var index:IndexPath!   /* IndexPath property still figuring out if I need it */
    
    var taskMethods = SharedTaskMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        edgesForExtendedLayout = []
        
        dataSource = HomeViewControllerDataSource()
        dataSource.setupView(tableView:tableView, view:view)
        addNavItemsToController()
    }
    
    /* Before view appears fetches tasks user data using helpers.getData method then for current user, if currentUser.tasks is not nil, it removes tasks from currentUser regardless it then fetches currentUser from database calling APIClient before loading. Redundant functionality, definitely could be streamlined */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if self.store.currentUser.tasks != nil {
                self.store.currentUser.tasks?.removeAll()
            }
            self.fetchUser() { user in
                self.store.currentUser = user
                self.tasks = self.store.currentUser.tasks!
            }
        }
    }
    
    func fetchUser(completion: @escaping UserCompletion) {
        store.tasks.removeAll()
        store.currentUser.tasks?.removeAll()
        store.firebaseAPI.fetchUserData { user in
            self.store.currentUser = user
        }
        store.firebaseAPI.fetchTasks(taskList: self.store.currentUser.tasks!) { tasks in
            self.store.currentUser.tasks = tasks
            self.store.tasks = tasks
            completion(self.store.currentUser)
        }
    }
    
    /* Removes reference to database - necessary to prevent duplicate task cells from loading when view will appears is called again. Called inside helpers class */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        helpers.removeRefHandle()
    }
    
    // MARK: - UITableViewController Methods
    // Returns number of rows based on count taskcount
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows
    }
    
    // Gets rowheight from datasource and returns it - rowheight is UITableViewAutomaticDimension
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeViewModel.rowHeight
    }
}

extension HomeViewController: UITextViewDelegate, TaskCellDelegate, ProfileHeaderCellDelegate {
    
    internal func profilePictureTapped(sender: UIGestureRecognizer) {
        print("here")
    }
    
    /* If first row returns profile header cell else returns task cell all cells configured within HomeViewController datasource class
     This setup is problematic when deleting task cells, causes tableview to lose track of proper index path when tableView is reloaded.
     Need fix. */
    
    // FIXME: - Fix so that tableview can delete tasks with index out of range getting thrown
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource.tableIndexPath = indexPath
        let cellType: HomeCellType = indexPath.row > 0 ? .task : .header
        switch cellType {
        case .task:
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath) as! TaskCell
            let reloadedIndex = indexPath.row - 1
            let taskViewModel = TaskCellViewModel((tasks[reloadedIndex]))
            taskCell.configureCell(taskVM: taskViewModel)
            dataSource.setupTaskCell(taskCell: taskCell, viewController: self)
            taskCell.tag = indexPath.row
            taskCell.delegate = self
            return taskCell
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath) as! ProfileHeaderCell
            headerCell.delegate = self
            dataSource.setupHeaderCell(headerCell: headerCell, viewController: self)
            return headerCell
        }
    }
    
    /* Logic for deleting tasks from database when user deletes tableview cell */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        if editingStyle == .delete {
            tableView.beginUpdates()
            backgroundQueue.async {
                self.taskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView)
                self.dataSource.tableIndexPath.row = indexPath.row
            }
            tableView.endUpdates()
        }
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if self.store.currentUser.tasks != nil {
                self.store.currentUser.tasks?.removeAll()
            }
            self.fetchUser() { user in
                self.store.currentUser = user
                self.tasks = self.store.currentUser.tasks!
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    /* Sets up action for logout button press, add task button press and adds these as selectors on
     navigation items which are added to navigation controller. */
    
    // MARK: Selector Methods
    
    /* Logs out user by settings root ViewController to Loginview */
    
    func logoutButtonPressed() {
        let loginVC = LoginViewController()
        let rootNC = UINavigationController(rootViewController:loginVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDataStore.sharedInstance.logout()
        appDelegate.window?.rootViewController = rootNC
    }
    
    /* Pushes AddTaskViewcontroller to current current view controller on button press */
    
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
    
    /* Hides popover view when operation has ended. */
    
    internal func hidePopoverView() {
        photoPopover.hidePopView(viewController: self)
    }
    
    /* Task cell Delegate Methods - Mainly toggling UI for edit state
     Method toggles UI states from editing to not editing when save is pressed */
    
    func toggleForButtonState(_ sender:UIButton) {
        let superview = sender.superview
        let cell = superview?.superview as! TaskCell
        let indexPath = tableView.indexPath(for: cell)
        taskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: indexPath!, type: .home)
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
    
    // MARK: - Header cell Delegate Methods
    // FIXME: - Fix so that image picker can be dismissed by clicking on popover containerview - Add profile picture storage methods
    
    internal func tapPickPhoto(_ sender:UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        photoPopover.hideView(viewController: self)
    }
}
