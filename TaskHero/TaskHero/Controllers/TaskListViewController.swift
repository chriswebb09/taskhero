//
//  TaskListViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    //et schema = Database.sharedInstance
    
    let addTasksLabel:UILabel = {
        let addTasksLabel = UILabel()
        addTasksLabel.font = UIFont(name:"HelveticaNeue-Thin", size: 18)
        addTasksLabel.textColor = UIColor.gray
        addTasksLabel.textAlignment = .center
        return addTasksLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        if (self.store.tasks.count < 1) && (!addTasksLabel.isHidden) {
            self.view.addSubview(addTasksLabel)
            addTasksLabel.center = self.view.center
            addTasksLabel.text = "No tasks have been added yet."
            addTasksLabel.translatesAutoresizingMaskIntoConstraints = false
            addTasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
            addTasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
            addTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if self.store.tasks.count < 1 {
            self.addTasksLabel.isHidden = false
        }
        edgesForExtendedLayout = []
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 18)!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.store.tasks.count >= 1 {
            addTasksLabel.isHidden = true
            addTasksLabel.isEnabled = false
        }
        self.store.tasks.removeAll()
        self.store.fetchTasks(completion: { (task) in
            self.store.tasks.append(task)
            self.tableView.reloadData()
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
        print("task count \(self.store.tasks.count)")
        return self.store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        let height = tableView.rowHeight - 5
        taskCell.layoutMargins = UIEdgeInsets.zero
        taskCell.preservesSuperviewLayoutMargins = false
        taskCell.layoutSubviews()
        taskCell.contentView.backgroundColor = UIColor.clear
        let cellView : UIView = UIView(frame: CGRect(x:0, y:1, width:self.view.frame.size.width, height:height))
        cellView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = 2.0
        cellView.layer.shadowOffset = CGSize(width:-0.5, height: 0.35)
        cellView.layer.shadowOpacity = 0.1
        taskCell.contentView.addSubview(cellView)
        taskCell.contentView.sendSubview(toBack: cellView)
        taskCell.taskNameLabel.text = self.store.tasks[indexPath.row].taskName
        taskCell.taskDescriptionLabel.text = "Task Description: \(self.store.tasks[indexPath.row].taskDescription)"
        taskCell.taskDueLabel.text = "Task was added: \(self.store.tasks[indexPath.row].taskDue)"
        if self.store.tasks[indexPath.row].taskCompleted {
            taskCell.taskCompletedView.image = UIImage(named:"checked")
        }
        return taskCell
    }
    
    func logoutButtonPressed() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            DispatchQueue.main.async {
                var removeTaskID: String
                print(indexPath.row)
                removeTaskID = self.store.tasks[indexPath.row].taskID
                self.store.currentUser.experiencePoints += self.store.tasks[indexPath.row].pointValue
                self.store.currentUser.numberOfTasksCompleted += 1
                self.store.insertUser(user: self.store.currentUser)
                self.store.removeTask(ref: removeTaskID)
                self.store.tasks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
            tableView.reloadData()
    }
    
}

