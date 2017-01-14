//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewController: UITableViewController, TaskCellDelegate {
    
    /* TaskListViewController is the viewcontroller that presents just the tasks that the user has added */
    // MARK: Properties
    
    let store = UserDataStore.sharedInstance /* userData store for application user state */
    var tapped: Bool = false /* tracks taps on taskcell completedView and button */
    var taskViewModel: TaskCellViewModel!
    let helpers = Helpers()
    
    // MARK: - UI Elements
    /* Label for empty tasklist state, should disappear once task is added */
    
    lazy var addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
}

extension TaskListViewController {
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        initializeBackgroundUI()
        tableView.reloadData()
    }
    
}


extension TaskListViewController {

    /* Does setupfor tableview/emptytable view and navbar */
    
    func initializeBackgroundUI() {
        emptyTableViewState()
        setupTableView()
        setupNavItems()
    }
}


extension TaskListViewController {
    
    // FIXME: - Refactor ASAP
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if store.tasks.count >= 1 {
            addTasksLabel.isHidden = true
            addTasksLabel.isEnabled = false
        }
        store.tasks.removeAll()
        if store.currentUser.tasks != nil {
            store.currentUser.tasks?.removeAll()
        }
        helpers.fetchUser() { user in
            self.store.currentUser = user
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        store.firebaseAPI.tasksRef.removeObserver(withHandle: store.firebaseAPI.refHandle)
    }
}

extension TaskListViewController {
    
    // MARK: - UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.tasks.count
    }
}


extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        let height = tableView.rowHeight - 5
        taskViewModel = TaskCellViewModel(store.tasks[indexPath.row])
        taskCell.delegate = self
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(_:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.configureCell(taskVM: taskViewModel)
        return taskCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let removeTaskID: String = self.store.tasks[indexPath.row].taskID
            deleteTasks(id: removeTaskID, indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            DispatchQueue.main.async { tableView.reloadData() }
        }
    }
}


