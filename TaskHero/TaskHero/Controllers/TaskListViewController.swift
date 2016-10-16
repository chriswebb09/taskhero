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
        
        


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}
