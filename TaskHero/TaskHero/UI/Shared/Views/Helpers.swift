//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

// ====================================================
// MARK: - MAJOR Refactor Necessary - Temporary setup
// ====================================================

extension UITableView {
    
    func setupTableView() {
        estimatedRowHeight = Constants.Settings.rowHeight
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.zero
        separatorStyle = .singleLineEtched
        rowHeight = UITableViewAutomaticDimension
        tableFooterView = UIView(frame: CGRect.zero)
        tableHeaderView?.backgroundColor = UIColor.white
    }
}

class Helpers {
    let store = UserDataStore.sharedInstance
}

extension Helpers {
    public func removeRefHandle() {
        if store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
}

extension Helpers {
    
    public func loadTabBar() {
        let tabBar = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    
    public func configureNav(nav:UINavigationBar, view: UIView) {
        nav.titleTextAttributes = Constants.Tabbar.navbarAttributedText
        nav.barTintColor = Constants.Tabbar.tint
        nav.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
    }
    
    public func setupTabBar(tabBar:UITabBar, view:UIView) {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.height * Constants.Tabbar.tabbarFrameHeight
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.isTranslucent = true
        tabBar.tintColor = Constants.Tabbar.tint
        tabBar.barTintColor = Constants.Color.backgroundColor
    }
}

extension Helpers {
    
    public func tapEdit(tableView: UITableView, atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapCell.taskDescriptionBox.resignFirstResponder()
        if tapCell.toggled == true {
            var newTask = self.store.tasks[atIndex.row - 1]
            newTask.taskDescription = tapCell.taskDescriptionBox.text
            self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            DispatchQueue.main.async {
                tapCell.taskDescriptionLabel.text = newTask.taskDescription
            }
            tapCell.taskDescriptionBox.resignFirstResponder()
        }
        
    }
    
    public func editList(tableView: UITableView, atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapCell.taskDescriptionBox.resignFirstResponder()
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
    
    public func updateDescription(cell:TaskCell, for row:Int) {
        var newTask = self.store.tasks[row - 1]
        cell.taskDescriptionBox.text = cell.taskDescriptionBox.text
        newTask.taskDescription = cell.taskDescriptionBox.text
        store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
        cell.taskDescriptionLabel.text = cell.taskDescriptionBox.text
    }
}


extension Helpers {
    
    public func handleLogout() {
        do {
            UserDataStore.sharedInstance.setLoggedInKey(userState: false)
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }; let loginController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginController
    }
    
    public func createUser(uid: String, username:String, email:String) -> User {
        let newUser = User()
        newUser.uid = uid
        newUser.username = username
        newUser.email = email
        newUser.profilePicture = "None"
        newUser.firstName = "N/A"
        newUser.lastName = "N/A"
        newUser.experiencePoints = 0
        newUser.tasks = [Task]()
        return newUser
    }
    
    public func fetchUser(completion: @escaping(User) -> Void) {
        store.tasks.removeAll()
        store.currentUser.tasks?.removeAll()
        store.firebaseAPI.fetchUserData { user in
            self.store.currentUser = user
        }
        store.firebaseAPI.fetchTasks(taskList: self.store.currentUser.tasks!) { tasks in
            self.store.currentUser.tasks = tasks
            self.store.tasks = tasks
            dump(self.store.currentUser)
            completion(self.store.currentUser)
        }
    }
    
    public func updateUserProfile(userID: String, user:User) {
        store.firebaseAPI.updateUserProfile(userID: userID, user: user, tasks:store.tasks)
        store.tasks.forEach { task in
            self.store.firebaseAPI.updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
    
    public func getData(tableView:UITableView) {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if self.store.currentUser.tasks != nil {
                self.store.currentUser.tasks?.removeAll()
            }
            self.fetchUser() { user in
                self.store.currentUser = user
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
}
