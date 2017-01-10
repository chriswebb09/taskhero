//
//  ProfileViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class ProfileViewController: UITableViewController {
    
    // =================================
    // MARK: - Internal Variables
    // =================================
    
    let store = DataStore.sharedInstance
    
}

extension ProfileViewController {
    
    // =============================
    // MARK: - Initialization
    // =============================
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
        // ================================
        // MARK: - Register cell types
        // ================================
        
        tableView.register(ProfileDataCell.self, forCellReuseIdentifier: ProfileDataCell.cellIdentifier)
        tableView.register(ProfileBannerCell.self, forCellReuseIdentifier: ProfileBannerCell.cellIdentifier)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.estimatedRowHeight = view.frame.height / 3
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Setup UI on main thread
        
        DispatchQueue.main.async {
            self.setupNavItems()
            self.tableView.reloadData()
        }
    }
    
    // On viewDidAppear ensure fresh user data from database is
    // loaded and reloads TableView
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ProfileViewController {
    
    // ========================================
    // MARK: UITableViewController Methods
    // ========================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // If first row set banner image
        
        if indexPath.row == 0 {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: ProfileBannerCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileBannerCell
            bannerCell.configureCell()
            return bannerCell
            
            // If second row return ProfileHeaderCell
            
        } else if indexPath.row == 1 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell(autoHeight: UIViewAutoresizing.flexibleHeight)
            return headerCell
            
            // Beyond that it's all ProfileDataCells
            
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.configureCell()
            return dataCell
        }
    }
}

extension ProfileViewController {
    
    // ===============================
    // MARK: - Delegate Methods
    // ===============================
    
    func setupNavItems() {
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.Border.borderWidth)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium], for: .normal)
    }
    
    // ============================
    // MARK: - Button methods
    // ============================
    
    // On logout button press sets RootViewController to LoginViewController on main thread
    
    func logoutButtonPressed() {
        DispatchQueue.main.async {
            let loginVC = UINavigationController(rootViewController:LoginViewController())
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DataStore.sharedInstance.logout()
            appDelegate.window?.rootViewController = loginVC
        }
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}
