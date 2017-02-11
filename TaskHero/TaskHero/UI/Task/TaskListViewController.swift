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
    
    var addTasksLabel:UILabel {
        didSet {
            print("Label hidden \(hidden)")
        }
    }
    
    var hidden: Bool {
        var conditional: Bool = true
        if let currentUser = store.currentUser {
            if let tasks = currentUser.tasks {
                if tasks.count < 1 {
                    conditional = false
                } else {
                    conditional = true
                }
            }
        }
        return conditional
    }
    
    // MARK: - Initialization
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init(_ coder: NSCoder? = nil) {
        self.addTasksLabel = UILabel()
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
}

extension TaskListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        initializeBackgroundUI()
        addTasksLabel = UILabel()
        configureAddTaskLabel(label: self.addTasksLabel)
        addTasksLabel.isHidden = hidden
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        store.firebaseAPI.tasksRef.removeObserver(withHandle: store.firebaseAPI.refHandle)
    }
    
    /* Does setupfor tableview/emptytable view and navbar */
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        self.helpers.reload(tableView: tableView)
        self.addTasksLabel.isHidden = hidden
        DispatchQueue.main.async {
            self.emptyTableViewState(addTaskLabel: self.addTasksLabel)
        }
        super.viewWillAppear(false)
    }
    
    func configureAddTaskLabel(label: UILabel) {
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
    }
    
    func initializeBackgroundUI() {
        sharedTaskMethods.setupTableView(tableView:tableView, view: view)
        setupNavItems(navController:navigationController)
    }
    
    func fetchUser() {
        self.store.firebaseAPI.fetchUserData() { user in
            self.store.firebaseAPI.fetchTaskList() { taskList in
                self.store.tasks = taskList
                DispatchQueue.main.async {
                    self.store.currentUser = user
                    self.helpers.reload(tableView: self.tableView)
                }
            }
        }
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
        if editingStyle == .delete {
            guard self.store.tasks.count > 0 else { return }
            tableView.beginUpdates()
            backgroundQueue.async {
                self.sharedTaskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView, type: .taskList)
            }
            self.fetchUser()
            addTasksLabel.isHidden = hidden
            tableView.endUpdates()
        }
    }
    
    func emptyTableViewState(addTaskLabel:UILabel) {
        if (store.tasks.count <= 1) && (!addTasksLabel.isHidden) {
            view.addSubview(addTasksLabel)
            addTasksLabel.center = view.center
            addTasksLabel.text = listViewModel.taskLabelText
            addTasksLabel.translatesAutoresizingMaskIntoConstraints = false
            addTasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
            addTasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.Dimension.width).isActive = true
            addTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            addTasksLabel.isHidden = false
        } else if store.tasks.count < 1 {
            addTasksLabel.isHidden = true
        } else if self.store.tasks.count == 0 {
            addTasksLabel.isHidden = false
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
        if let index = indexPath {
            sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: index, type: .taskList)
        }
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: tapIndex, type: .taskList)
    }
}
