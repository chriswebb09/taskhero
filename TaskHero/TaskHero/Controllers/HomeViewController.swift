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
    var tasksList = [Task]()
    var tasks: [Task]? {
        set {
            if let tasks = tasks {
                tasksList = tasks
                tableView.reloadData()
            }
        }
        get {
            if tasksList.isEmpty {
                return nil
            } else {
                return tasksList
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: 2.0)
        view.backgroundColor = Constants.tableViewBackgroundColor
        edgesForExtendedLayout = []
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        setupTableView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.Font.helveticaLight, size: 18)!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.fetchUserData()
        super.viewWillAppear(false)
        self.store.tasks.removeAll()
        self.store.fetchTasks(completion: { (task) in
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
}

extension HomeViewController {
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell(user: self.store.currentUser)
            return headerCell
        } else {
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
            let height = tableView.rowHeight - 5
            let cellindex = (indexPath.row) - 1
            taskCell.configureCell(task: self.store.tasks[cellindex])
            taskCell.setupCellView(width: self.view.frame.size.width, height:height)
            return taskCell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            DispatchQueue.main.async {
                var removeTaskID: String
                if (indexPath.row) == 0 {
                    return
                } else {
                    removeTaskID = self.store.tasks[indexPath.row - 1].taskID
                    self.store.currentUser.experiencePoints += self.store.tasks[indexPath.row - 1].pointValue
                    self.store.currentUser.numberOfTasksCompleted += 1
                    self.store.insertUser(user: self.store.currentUser)
                }
                
                self.store.removeTask(ref: removeTaskID)
                self.store.tasks.remove(at: indexPath.row - 1)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.endUpdates()
            }
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}

extension HomeViewController {
    
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
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
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}
