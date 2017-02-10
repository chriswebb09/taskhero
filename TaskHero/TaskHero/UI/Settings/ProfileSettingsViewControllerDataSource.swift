//
//  ProfileSettingsViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class ProfileSettingsViewControllerDataSource {
    
    // MARK: - Deallocation from memory
    
    deinit {
        print("ProfileSettingsViewControllerDataSource deallocated")
    }
    
    // MARK: - Properties
    
    let store = UserDataStore.sharedInstance
    
    func setupViews(profileSettingsView: ProfileSettingsView, tableView: UITableView, view:UIView) {
        profileSettingsView.translatesAutoresizingMaskIntoConstraints = false
        profileSettingsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileSettingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        profileSettingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Settings.Profile.profileViewHeightAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Settings.tableViewHeight).isActive = true
    }
    
    func updateUserName(cell: ProfileSettingsCell, name:[String]) {
        var name = cell.profileSettingField.text?.components(separatedBy: " ")
        let updatedUser = User()
        updatedUser.username = store.currentUser.username
        updatedUser.email = store.currentUser.email
        updatedUser.profilePicture = "None"
        updatedUser.firstName = name?[0]
        updatedUser.lastName = name?[1]
        updatedUser.joinDate = store.currentUser.joinDate
        updatedUser.numberOfTasksCompleted = store.currentUser.numberOfTasksCompleted
        updatedUser.experiencePoints = store.currentUser.experiencePoints
        updatedUser.tasks = store.currentUser.tasks
        updateUserProfile(userID: store.currentUser.uid, user: updatedUser)
    }
    
    func updateUserProfile(userID: String, user:User) {
        store.firebaseAPI.updateUserProfile(userID: userID, user: user, tasks:store.tasks)
        store.tasks.forEach { task in
            self.store.firebaseAPI.updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
    
        func setupUser(user: User) {
            store.firebaseAPI.registerUser(user: user)
           // store.currentUserString = FIRAuth.auth()?.currentUser?.uid
            store.firebaseAPI.setupRefs()
            store.currentUser = user
        }

}
