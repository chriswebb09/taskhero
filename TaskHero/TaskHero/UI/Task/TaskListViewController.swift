//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewController: UITableViewController, TaskCellDelegate {
    
    // ================================
    // MARK: Internal Variables
    // ================================
    
    let store = DataStore.sharedInstance
    var tapped: Bool = false
    var buttonTapped: Bool = false
    var taskViewModel: TaskCellViewModel!
    let helpers = Helpers()
    
    // =======================
    // MARK: - UI
    // =======================
    
    let addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
}

extension TaskListViewController {
    
    // ===============================
    // MARK: - Initialization
    // ===============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        initializeBackgroundUI()
        tableView.reloadData()
    }
    
    fileprivate func initializeBackgroundUI() {
        emptyTableViewState()
        setupTableView()
        setupNavItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       
        if store.tasks.count >= 1 {
            addTasksLabel.isHidden = true
            addTasksLabel.isEnabled = false
        }
        
        self.store.tasks.removeAll()
        if self.store.currentUser.tasks != nil {
            self.store.currentUser.tasks?.removeAll()
        }
        
        self.store.fetchUser() { user in
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
    
    // =======================================
    // MARK: - UITableViewController Methods
    // =======================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        let height = tableView.rowHeight - 5
        taskViewModel = TaskCellViewModel(store.tasks[indexPath.row])
        taskCell.delegate = self
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(sender:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.configureCell(taskVM: taskViewModel)
        taskCell.setupCellView(width: view.frame.size.width, height:height)
        return taskCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let removeTaskID: String = self.store.tasks[indexPath.row].taskID
            deleteTasks(id: removeTaskID, indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            DispatchQueue.main.async { tableView.reloadData() }
        }
    }
}


