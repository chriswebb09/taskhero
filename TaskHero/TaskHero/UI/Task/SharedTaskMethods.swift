//
//  SharedTaskMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/7/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum TaskListType {
    case home, taskList
}


class SharedTaskMethods {
    
    let store = UserDataStore.sharedInstance
    
    @objc func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDataStore.sharedInstance.logout()
        appDelegate.window?.rootViewController = loginVC
    }
    
    func deleteTask(indexPath: IndexPath, tableView:UITableView, type: TaskListType) {

        var rowIndex: Int
        switch type {
        case .home:
            rowIndex = indexPath.row - 1
        case .taskList:
            rowIndex = indexPath.row
        }
        
        DispatchQueue.global(qos: .default).async {
            let removeTaskID: String = self.store.currentUser.tasks![rowIndex].taskID
            if let tasks = self.store.currentUser.tasks { self.store.tasks = tasks }
            print(indexPath.row - 1)
            self.store.tasks.remove(at: indexPath.row - 1)
            self.store.updateUserScore()
            self.store.firebaseAPI.registerUser(user: self.store.currentUser)
            self.store.firebaseAPI.removeTask(ref: removeTaskID, taskID: removeTaskID)
        }
        print(self.store.tasks)
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    
    func tapEdit(viewController: UIViewController, tableView: UITableView, atIndex:IndexPath, type: TaskListType) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        var newTask: Task!
        switch type {
        case .home:
            newTask = self.store.tasks[atIndex.row - 1]
        case .taskList:
            newTask = self.store.tasks[atIndex.row]
        }
        
        if tapCell.toggled == false {
            newTask.taskDescription = tapCell.taskDescriptionLabel.text
            self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            tapCell.taskDescriptionLabel.text = newTask.taskDescription
        }
        let tap = UIGestureRecognizer(target: viewController, action: #selector(HomeViewController.toggleForEditState(_:)))
        tapCell.taskCompletedView.addGestureRecognizer(tap)
        tapCell.taskCompletedView.isUserInteractionEnabled = true
    }
}
