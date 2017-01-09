//
//  ProfileSettingsViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class ProfileSettingsViewControllerDataSource {
    
    let store = DataStore.sharedInstance
    
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
    
    func updateUserNames(cell: ProfileSettingsCell, name:[String]) {
        var name = cell.profileSettingField.text?.components(separatedBy: " ")
        let updatedUser = User()
        var helpers = Helpers()
        updatedUser.username = self.store.currentUser.username
        updatedUser.email = self.store.currentUser.email
        updatedUser.profilePicture = "None"
        updatedUser.firstName = name?[0]
        updatedUser.lastName = name?[1]
        updatedUser.joinDate = self.store.currentUser.joinDate
        updatedUser.numberOfTasksCompleted = self.store.currentUser.numberOfTasksCompleted
        updatedUser.experiencePoints = self.store.currentUser.experiencePoints
        updatedUser.tasks = self.store.currentUser.tasks
        helpers.updateUserProfile(userID: self.store.currentUser.uid, user: updatedUser)
    }
    
    func updateUserName(cell:ProfileSettingsCell, name: [String]) {
        let updatedUser = User()
        updatedUser.username = cell.profileSettingField.text!
        updatedUser.email = self.store.currentUser.email
        updatedUser.profilePicture = "None"
        updatedUser.firstName = name[0]
        updatedUser.lastName = name[1]
        updatedUser.joinDate = self.store.currentUser.joinDate
        updatedUser.numberOfTasksCompleted = self.store.currentUser.numberOfTasksCompleted
        updatedUser.experiencePoints = self.store.currentUser.experiencePoints
        updatedUser.tasks = self.store.currentUser.tasks
    }
    
}
