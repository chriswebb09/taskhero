//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController, UISearchResultsUpdating {
    
    var parentNavigationController: UINavigationController?
    var searchController = UISearchController(searchResultsController: nil)
    var databaseRef: FIRDatabaseReference!
   // var tasksDataSnapshot = [FIRDataSnapshot]()
    var tasks = [Task]()
    let uid = FIRAuth.auth()!.currentUser!.uid
    //var databaseRef: FIRDatabaseReference!
    //var storageRef: FIRStorageReference!
    
   
    
    
    
    override func viewDidLoad() {
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        self.databaseRef = FIRDatabase.database().reference(withPath:"users/\(uid)/tasks/")
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.white
        
        getAllTasks()
        
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-gray")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
        
//        let barButton = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
//        barButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.font, size: 20)!], for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!], for: .normal)
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "Search Tasks"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.black
    }
    
    deinit {
        searchController.loadViewIfNeeded()
        let _ = searchController.view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        tableView.reloadData()
    }
    
    func getAllTasks() {
        tasks.removeAll()
        databaseRef.observe(.childAdded, with: { (snapshot) -> Void in
            let data = snapshot.value
            let task = Task()
            guard let snapshotValue = data as? NSDictionary else { return }
            if let taskDescription = snapshotValue["taskDescription"] as? String {
                task.taskDescription = taskDescription
            }
            if let taskName = snapshotValue["taskName"] as? String {
                task.taskName = taskName
            }
            if let taskDue = snapshotValue["taskDue"] as? String {
                task.taskDue = taskDue
            }
            if let taskCompleted = snapshotValue["completed"] as? Bool {
                task.completed = taskCompleted
            }
            if let taskID = snapshotValue["taskID"] as? String {
                task.taskID = taskID
            }
            self.tasks.insert(task, at: 0)
            self.tableView.reloadData()
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            
            cell.layoutSubviews()
            cell.usernameLabel.text = "filler text"
            cell.profilePicture.backgroundColor = UIColor.blue
            cell.profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped)))
            return cell
        } else {
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
            
            taskCell.layoutSubviews()
            taskCell.taskNameLabel.text = tasks[indexPath.row].taskName
            taskCell.taskDetailLabel.text = tasks[indexPath.row].taskDescription
            taskCell.taskDue.text =  tasks[indexPath.row].taskDue
            
            if tasks[indexPath.row].completed == true {
                
                taskCell.taskCompletedLabel.image = UIImage(named: "checked")
                
            } else if tasks[indexPath.row].completed == false {
                
                taskCell.taskCompletedLabel.image = UIImage(named: "cancel")
                
            }
            
            return taskCell
        }
    }
    
    
    
    
}

extension HomeViewController: ProfileHeaderCellDelegate {
    
    func logoutButtonPressed() {
        
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginVC
    }
    
    func profilePictureTapped() {
        print("profile picture tapped")
        let profilePicVC = ProfilePictureViewController()
        navigationController?.pushViewController(profilePicVC, animated:false)
    }
    
    func addTaskButtonTapped() {
        let addTaskVC = AddTaskViewController()
        navigationController?.pushViewController(addTaskVC, animated:false)
    }
}

