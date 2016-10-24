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
        
        self.navigationController?.navigationBar.setBottomBorderColor(color: UIColor.gray, height: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.helveticaLight, size: 18)!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.store.fetchUser(completion: { (user) in
            print(user)
        })
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: ProfileBannerCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileBannerCell
            
            bannerCell.layoutSubviews()
            bannerCell.isUserInteractionEnabled = false
            bannerCell.layoutMargins = UIEdgeInsets.zero
            bannerCell.preservesSuperviewLayoutMargins = false
            bannerCell.backgroundColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
            
            return bannerCell
        } else if indexPath.row == 1 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            
            headerCell.layoutSubviews()
            headerCell.isUserInteractionEnabled = false
            headerCell.layoutMargins = UIEdgeInsets.zero
            headerCell.preservesSuperviewLayoutMargins = false
            headerCell.emailLabel.isHidden = false
            headerCell.profilePicture.image = UIImage(named: "defaultUserImage")
            headerCell.usernameLabel.text = self.store.currentUser.username
            headerCell.emailLabel.text = self.store.currentUser.email
            headerCell.joinDateLabel.text = "Member since: \(self.store.currentUser.joinDate)"
            
            return headerCell
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for:indexPath as IndexPath) as! ProfileDataCell
            
            dataCell.layoutSubviews()
            dataCell.layoutMargins = UIEdgeInsets.zero
            dataCell.levelLabel.text = "Level: \(self.store.currentUser.level)"
            dataCell.experiencePointsLabel.text = "Experience: \(String(describing: self.store.currentUser.experiencePoints))"
            dataCell.tasksCompletedLabel.text = "Tasks completed: \(String(describing: self.store.currentUser.numberOfTasksCompleted))"
            
            return dataCell
        }
    }
    
    func logoutButtonPressed() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func addTaskButtonTapped() {
        //navigationController?.pushViewController(SignupViewController(), animated: false)
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    
}
