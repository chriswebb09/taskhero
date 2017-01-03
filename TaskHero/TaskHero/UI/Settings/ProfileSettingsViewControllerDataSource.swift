//
//  ProfileSettingsViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileSettingsViewControllerDataSource {
    
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
    
}
