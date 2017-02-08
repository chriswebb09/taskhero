//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

// MARK: - MAJOR Refactor Necessary - Temporary setup


final class Helpers {
    let store = UserDataStore.sharedInstance
    
    func createUser(uid: String, username:String, email:String) -> User {
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
    
    func removeRefHandle() {
        if store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
    
    func loadTabBar(tabBar:TabBarController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    
   
    class func setupTabBar(tabBar:UITabBar, view:UIView) {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.height * Constants.Tabbar.tabbarFrameHeight
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.isTranslucent = true
        tabBar.tintColor = Constants.Tabbar.tint
        tabBar.barTintColor = Constants.Color.backgroundColor
    }
    
    func handleLogout() {
        do {
            UserDataStore.sharedInstance.setLoggedInKey(userState: false)
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }; let loginController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginController
    }
    
    func fetchUser(completion: @escaping UserCompletion) {
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
    
    func reload(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
}
