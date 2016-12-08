//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewController: UITableViewController, TaskCellDelegate {
    
    // MARK: Internal Variables
    
    let store = DataStore.sharedInstance
    var tapped: Bool = false
    var buttonTapped: Bool = false
    
    // MARK: - UI
    
    let addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = Constants.TaskList.tableBackgroundColor
        emptyTableViewState()
        setupTableView()
        setupNavItems()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TaskListViewController {
    
    // MARK: - Initialization
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.store.fetchUserData()
        if store.tasks.count >= 1 {
            addTasksLabel.isHidden = true
            addTasksLabel.isEnabled = false
        }
        store.tasks.removeAll()
        store.fetchTasks(completion: { task in
            self.store.tasks.append(task)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        store.tasksRef.removeObserver(withHandle: store.refHandle)
    }
    
    // MARK: - UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        let height = tableView.rowHeight - 5
        let cellindex = (indexPath.row)
        taskCell.delegate = self
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(sender:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.configureCell(task: store.tasks[cellindex])
        taskCell.setupCellView(width: view.frame.size.width, height:height)
        return taskCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            var removeTaskID: String
            removeTaskID = self.store.tasks[indexPath.row].taskID
            self.store.currentUser.experiencePoints += 1
            self.store.currentUser.numberOfTasksCompleted += 1
            self.store.insertUser(user: self.store.currentUser)
            self.store.removeTask(ref: removeTaskID, taskID: removeTaskID)
            self.store.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } else if editingStyle == .insert {
            // Not implemented
        }
    }
}

extension TaskListViewController: TaskHeaderCellDelegate {
    
    // MARK: - Public Methods
    
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Tasks To Do")
        default:
            print("Tasks Completed")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Setup navbar
    
    func setupNavItems() {
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: 2.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    
    // MARK: - Button methods
    
    func logoutButtonPressed() {
        DispatchQueue.main.async {
            let loginVC = UINavigationController(rootViewController:LoginViewController())
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = loginVC
        }
    }
    
    func addTaskButtonTapped() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(AddTaskViewController(), animated:false)
        }
    }
    
    func tapEdit(atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapped = !tapped
        tapCell.toggled! = tapped
        tapCell.buttonToggled = !tapped
        print("Task toggle \(tapCell.toggled)")
        print("Button toggle \(tapCell.buttonToggled)")
        if tapCell.buttonToggled == true {
            var newTask = self.store.tasks[atIndex.row]
            newTask.taskDescription = tapCell.taskDescriptionBox.text
            self.store.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            tapCell.taskDescriptionLabel.text = tapCell.taskDescriptionBox.text
            tapCell.taskDescriptionBox.resignFirstResponder()
        }
    }
    
    func toggleForButtonState(sender:UIButton) {
        buttonTapped = true
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        tapEdit(atIndex: indexPath!)
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        tapEdit(atIndex: tapIndex as IndexPath)
    }
}
