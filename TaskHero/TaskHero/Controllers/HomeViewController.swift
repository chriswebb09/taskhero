//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    let schema = Database.sharedInstance
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        let leftButton =  UIBarButtonItem(title: "Left Button", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = leftButton
        
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        edgesForExtendedLayout = []
        
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.store.tasks.count < 1 {
            return 1
        } else {
            return self.store.tasks.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            
            headerCell.layoutMargins = UIEdgeInsets.zero
            headerCell.preservesSuperviewLayoutMargins = false
            headerCell.layoutSubviews()
            headerCell.layoutIfNeeded()
            
            headerCell.usernameLabel.text = self.store.currentUser.username
            headerCell.profilePicture.image = UIImage(named: "defaultUserImage")
            headerCell.joinDateLabel.text = "Member since: \(self.store.currentUser.joinDate)"
            headerCell.levelLabel.text = self.store.currentUser.level
            return headerCell
        } else {
            
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
            
            
            let cellindex = (indexPath.row) - 1
            taskCell.contentView.addSubview(cellView)
            taskCell.contentView.sendSubview(toBack: cellView)
            
            taskCell.taskNameLabel.text = self.store.tasks[cellindex].taskName
            taskCell.taskDescriptionLabel.text = "Task Description: \(self.store.tasks[cellindex].taskDescription)"
            taskCell.taskDueLabel.text = "Task was added: \(self.store.tasks[cellindex].taskDue)"
            
            if self.store.tasks[cellindex].taskCompleted {
                taskCell.taskCompletedView.image = UIImage(named:"checked")
            }
            
            return taskCell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            
            
            print("ROWS \(self.tableView.numberOfRows(inSection: 0))")
            
            
            
            
            DispatchQueue.main.async {
                var removeTaskID: String
                if (indexPath.row) == 0 {
                    print("top")
                    print(indexPath.row)
                    return
                } else {
                    print(indexPath.row)
                    removeTaskID = self.store.tasks[indexPath.row - 1].taskID
                    self.store.currentUser.experiencePoints += self.store.tasks[indexPath.row - 1].pointValue
                }
                print("INDEX PATH \(indexPath.row)")
                print(removeTaskID)
                self.schema.removeTask(ref: removeTaskID)
                self.store.tasks.remove(at: indexPath.row - 1)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            tableView.reloadData()
            
            
            
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    func setupAlert() {
        let alertController = UIAlertController(title: "Delete", message: "Edit\nor Delete Task?", preferredStyle: .alert)
        
        let actionYes = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            print("delete")
        }
        
        let actionNo = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
            print("dont delete")
        }
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        self.present(alertController, animated: true, completion:nil)
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
    
}
