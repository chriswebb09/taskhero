//
//  ProfileViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    let schema = Database.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.register(ProfileBannerCell.self, forCellReuseIdentifier: ProfileBannerCell.cellIdentifier)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(ProfileDataCell.self, forCellReuseIdentifier: ProfileDataCell.cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 3
        tableView.reloadData()
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: ProfileBannerCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileBannerCell
            bannerCell.layoutSubviews()
            bannerCell.layoutMargins = UIEdgeInsets.zero
            bannerCell.preservesSuperviewLayoutMargins = false
            bannerCell.bannerImage.image = UIImage(named: "banner")
            
            return bannerCell
        } else if indexPath.row == 1 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.layoutSubviews()
            headerCell.layoutMargins = UIEdgeInsets.zero
            headerCell.preservesSuperviewLayoutMargins = false
            headerCell.profilePicture.image = UIImage(named: "profileImage")
            headerCell.usernameLabel.text = self.store.currentUser.username
            headerCell.joinDateLabel.text = "Today"
            return headerCell
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.layoutSubviews()
            dataCell.layoutMargins = UIEdgeInsets.zero
            dataCell.preservesSuperviewLayoutMargins = false
            dataCell.levelLabel.text = "Level 10"
            return dataCell
        }
    }
    
    
}
