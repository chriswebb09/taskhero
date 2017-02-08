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
