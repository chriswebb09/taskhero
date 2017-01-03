//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


extension UITableView {
    func setupHelper() {
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.separatorStyle = .singleLine
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.allowsSelection = false
        self.rowHeight = UITableViewAutomaticDimension
    }
}


class Helpers {
    let store = DataStore.sharedInstance
    
    func getTasks(tableView: UITableView) {
        store.setupStore()
        store.firebaseAPI.fetchTasks() { task in
            self.store.tasks.append(task)
            self.store.currentUser.tasks?.append(task)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func removeRefHandle() {
        if self.store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
    
    func setupTableView(tableView:UITableView) {
        tableView.estimatedRowHeight = Constants.Settings.rowHeight
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .singleLineEtched
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView?.backgroundColor = UIColor.white
    }
    
    func updateDescription(cell:TaskCell, for row:Int) {
        var newTask = self.store.tasks[row - 1]
        cell.taskDescriptionBox.text = cell.taskDescriptionBox.text
        newTask.taskDescription = cell.taskDescriptionBox.text
        self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
        cell.taskDescriptionLabel.text = cell.taskDescriptionBox.text
    }
    
    func tapEdit(tableView: UITableView, atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        if tapCell.toggled == true {
            var newTask = self.store.tasks[atIndex.row]
            newTask.taskDescription = tapCell.taskDescriptionBox.text
            self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            DispatchQueue.main.async {
                tapCell.taskDescriptionLabel.text = newTask.taskDescription
            }
            tapCell.taskDescriptionBox.resignFirstResponder()
        }
    }
}
