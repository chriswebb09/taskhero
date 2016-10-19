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
    let schema = Database.sharedInstance
    
    
    override func viewDidLoad() {
        
        print("task list view controller")
        
        print("tasks inside task list view controller \(self.store.tasks)")
        super.viewDidLoad()
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let taskQueue = OperationQueue()
        taskQueue.qualityOfService = .userInitiated
        taskQueue.name = "come.taskhero.tasks"
        taskQueue.maxConcurrentOperationCount = 2
        super.viewWillAppear(false)
        self.store.tasks.removeAll()
        taskQueue.addOperation {
            self.schema.fetchTasks(completion: { (task) in
                self.store.tasks.append(task)
                self.tableView.reloadData()
            })
        }
    }
    
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        schema.tasksRef.removeObserver(withHandle: schema.refHandle)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        taskCell.layoutSubviews()
        taskCell.taskNameLabel.text = self.store.tasks[indexPath.row].taskName
        taskCell.taskDescriptionLabel.text = "Task Description: \(self.store.tasks[indexPath.row].taskDescription)"
        taskCell.taskDueLabel.text = "Task was added: \(self.store.tasks[indexPath.row].taskDue)"
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
            
            print("ROWS \(self.tableView.numberOfRows(inSection: 0))")
            
            DispatchQueue.main.async {
                var removeTaskID: String
               
                print("top")
                print(indexPath.row)
                removeTaskID = self.store.tasks[indexPath.row].taskID
                self.store.currentUser.experiencePoints += self.store.tasks[indexPath.row].pointValue
                self.store.currentUser.numberOfTasksCompleted += 1
                self.schema.insertUser(user: self.store.currentUser)
                print("INDEX PATH \(indexPath.row)")
                print(removeTaskID)
                self.schema.removeTask(ref: removeTaskID)
                self.store.tasks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            tableView.reloadData()
        }
        
    }
    
}
