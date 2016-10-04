//
//  ProfileViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    //var settings = ["Privacy", "Tasks", "Profile Information", "Application Settings"]
    
    override func viewDidLoad() {
        tableView.register(ProfileBannerCell.self, forCellReuseIdentifier: ProfileBannerCell.cellIdentifier)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(ProfileDataCell.self, forCellReuseIdentifier: ProfileDataCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 300
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileBannerCell.cellIdentifier, for: indexPath as IndexPath) as!     ProfileBannerCell
            cell.layoutSubviews()
            cell.bannerImageView?.backgroundColor = UIColor.blue
            //cell.taskDetailLabel.text = settings[indexPath.row]
            return cell
        } else if indexPath.row == 1 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.layoutSubviews()
            // cell.profilePicture.backgroundColor = UIColor.blue
            headerCell.usernameLabel.text = "Username filler text"
            return headerCell
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileDataCell
            dataCell.layoutSubviews()
            dataCell.fullNameLabel.text = "Filler full name"
            dataCell.joinDateLabel.text = "April, 2nd, 2016"
            
            dataCell.experiencePointsLabel.text = "Points: 10230"
            dataCell.levelLabel.text = "TaskWizard"
            dataCell.publicTasks.text = "Task 1, Task 2"
            dataCell.teamsLabel.text = "Team Tiger"
            return dataCell
        }
    }
    
    
}


