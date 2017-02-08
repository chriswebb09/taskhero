//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewController: UITableViewController {
    
    /* TaskListViewController is the viewcontroller that presents just the tasks that the user has added */
    // MARK: Properties
    
    let store = UserDataStore.sharedInstance /* userData store for application user state */
    var tapped: Bool = false /* tracks taps on taskcell completedView and button */
    var taskViewModel: TaskCellViewModel!
    let helpers = Helpers()
    let sharedTaskMethods = SharedTaskMethods()
    var listViewModel = TaskListViewModel()
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)  // BackgroundQueue for background
    
    // MARK: - UI Elements
    /* Label for empty tasklist state, should disappear once task is added */
    
    lazy var addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
    
    var hidden: Bool {
        if let tasks = store.currentUser.tasks {
            if tasks.count < 1 {
                return false
            }
        }
        return true
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        initializeBackgroundUI()
        tableView.reloadData()
    }
    
    /* Does setupfor tableview/emptytable view and navbar */
    
    func initializeBackgroundUI() {
        emptyTableViewState(addTaskLabel: addTasksLabel)
        sharedTaskMethods.setupTableView(tableView:tableView, view: view)
        setupNavItems(navController:navigationController)
    }
    
    // FIXME: - Refactor ASAP
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        store.tasks.removeAll()
        if store.currentUser.tasks != nil {
            store.currentUser.tasks?.removeAll()
        }
        helpers.fetchUser() { user in
            self.store.currentUser = user
            DispatchQueue.main.async {
                self.emptyTableViewState(addTaskLabel: self.addTasksLabel)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        store.firebaseAPI.tasksRef.removeObserver(withHandle: store.firebaseAPI.refHandle)
    }
}


// MARK: - UITableViewController Methods
extension TaskListViewController: TaskCellDelegate {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        _ = tableView.rowHeight - 5
        taskViewModel = TaskCellViewModel(store.tasks[indexPath.row])
        taskCell.delegate = self
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(_:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.configureCell(taskVM: taskViewModel)
        return taskCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        if editingStyle == .delete {
            tableView.beginUpdates()
            backgroundQueue.async {
                self.sharedTaskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView, type: .home)
            }
            helpers.reload(tableView: tableView)
            tableView.endUpdates()
        }
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if self.store.currentUser.tasks != nil {
                self.store.currentUser.tasks?.removeAll()
            }
            self.fetchUser() { user in
                self.store.currentUser = user
            }
             self.emptyTableViewState(addTaskLabel: self.addTasksLabel)
            self.helpers.reload(tableView: tableView)
        }
    }
    
    // MARK: - TaskList UI
    
    func emptyTableViewState(addTaskLabel:UILabel) {
        if (store.tasks.count < 1) && (!addTasksLabel.isHidden) {
            view.addSubview(addTasksLabel)
            addTasksLabel.center = self.view.center
            addTasksLabel.text = listViewModel.taskLabelText
            addTasksLabel.translatesAutoresizingMaskIntoConstraints = false
            addTasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
            addTasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.Dimension.width).isActive = true
            addTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if store.tasks.count < 1 {
            addTasksLabel.isHidden = false
        } else {
            addTasksLabel.isHidden = true
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
    
    // MARK: - Public Methods
    
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Tasks To Do")
        default:
            print("Tasks Completed")
        }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    // MARK: - Setup navbar
    
    func setupNavItems(navController:UINavigationController?) {
        navController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.NavBar.bottomHeight)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    // MARK: - Button methods
    
    func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        DataPeristence.shared.logout()
        appDelegate.window?.rootViewController = loginVC
    }
    
    // MARK: - Task Actions
    
    dynamic fileprivate func addTaskButtonTapped() {
        self.navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    // MARK: - Cell Button Toggle Methods
    
    func toggleForButtonState(_ sender:UIButton) {
        let superview = sender.superview
        guard let cell = superview?.superview as? TaskCell else { return }
        let indexPath = tableView.indexPath(for: cell)
        sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: indexPath!, type: .taskList)
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: tapIndex, type: .taskList)
    }
}
