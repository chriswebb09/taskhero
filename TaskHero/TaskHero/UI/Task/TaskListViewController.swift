//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewController: UITableViewController, TaskCellDelegate {
    
    let store = DataStore.sharedInstance
    //let manager = AppManager.sharedInstance
    var tapped: Bool = false
    var buttonTapped: Bool = false
    
    fileprivate let addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = Constants.Font.fontNormal
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
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
    
    dynamic func setupNavItems() {
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: 2.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontSmall], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
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
}

extension TaskListViewController {
    
    fileprivate func tapEdit(atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapped = !tapped
        tapCell.toggled! = tapped
        tapCell.buttonToggled = !tapped
        print("Task toggle \(tapCell.toggled)")
        print("Button toggle \(tapCell.buttonToggled)")
        if tapCell.buttonToggled == true {
            tapCell.taskDescriptionLabel.text = tapCell.taskDescriptionBox.text
            // formatTaskWithData(indexPath: newIndex, taskDescription: tapCell.taskDescriptionBox.text!)
        }
        
    }
    
    func emptyTableViewState() {
        if (store.tasks.count < 1) && (!addTasksLabel.isHidden) {
            view.addSubview(addTasksLabel)
            addTasksLabel.center = self.view.center
            addTasksLabel.text = "No tasks have been added yet."
            addTasksLabel.translatesAutoresizingMaskIntoConstraints = false
            addTasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Profile.profileHeaderLabelHeight).isActive = true
            addTasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
            addTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if store.tasks.count < 1 {
            addTasksLabel.isHidden = false
        }
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func toggleForButtonState(sender:UIButton) {
        buttonTapped = true
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        tapEdit(atIndex: indexPath!)
    }
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        tapEdit(atIndex: tapIndex as IndexPath)
    }
}

