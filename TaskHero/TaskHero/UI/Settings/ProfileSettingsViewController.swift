//
//  ProfileSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class ProfileSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let store = DataStore.sharedInstance
    let profileSettingsView = ProfileSettingsView()
    var tapped: Bool = false
    var indexTap: IndexPath?
    let tableView = UITableView()
    
    fileprivate var options = ["Email Address", "Name", "Profile Picture", "Username"]
    
    var username: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        options = [self.store.currentUser.email, "\(self.store.currentUser.firstName!) \(self.store.currentUser.lastName!)", "Profile Picture", self.store.currentUser.username]
        
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(profileSettingsView)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.cellIdentifier)
        
        profileSettingsView.layoutSubviews()
        setupViews()
        setupTableView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileSettingsViewController: UITextFieldDelegate, ProfileSettingsCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    fileprivate func setupViews() {
        profileSettingsView.translatesAutoresizingMaskIntoConstraints = false
        profileSettingsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileSettingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        profileSettingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Settings.profileViewHeightAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Settings.tableViewHeight).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileSettingsCell
        
        cell.configureCell(setting: options[indexPath.row])
        cell.delegate = self
        cell.button.index = indexPath
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action:#selector(connected(sender:)), for: .touchUpInside)
        return cell
    }
}

extension ProfileSettingsViewController {
    
    func connected(sender: TagButton){
        indexTap = sender.index
        tapEdit()
    }
    
    fileprivate func tapEdit() {
        let tapCell = tableView.cellForRow(at: indexTap!) as! ProfileSettingsCell
        if tapped == true { tapped = false
            if (tapCell.profileSettingField.text?.characters.count)! > 0 {
                tapCell.profileSettingLabel.text = tapCell.profileSettingField.text
            } else { tapCell.profileSettingLabel.text = options[(indexTap?.row)!] }
            tapCell.profileSettingField.isHidden = true
            tapCell.profileSettingLabel.isHidden = false
        } else if tapped == false { tapped = true
            tapCell.profileSettingLabel.isHidden = true
            tapCell.profileSettingField.isHidden = false
        }
    }
    
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = Constants.Settings.rowHeight
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    fileprivate func separateNames(name:String) -> [String] {
        var nameArray = name.components(separatedBy: " ")
        return nameArray
    }
    
    func editButtonTapped() {
        tapped = true
    }
}
