//
//  ProfileSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ProfileSettingsCellDelegate {
    let store = DataStore.sharedInstance
    let profileSettingsView = ProfileSettingsView()
    var tapped: Bool = false
    var indexTap: IndexPath?
    let tableView = UITableView()

    var options = ["Email Address", "Name", "Profile Picture", "Username"]
    
    var username: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func setupViews() {
        profileSettingsView.translatesAutoresizingMaskIntoConstraints = false
        profileSettingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false 
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileSettingsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileSettingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileSettingsCell
        cell.configureCell(setting: options[indexPath.row])
        cell.delegate = self
        cell.button.tag = indexPath.row
        cell.button.index = indexPath
        //indexTap = indexPath
        //button.tag
        //cell.editButtonTapped()
        cell.button.addTarget(self, action:#selector(connected(sender:)), for: .touchUpInside)
        
//        if tapped == true {
//            cell.
//        }
        
        //let sel = #selector(getter: ProfileSettingsViewController.tableView(_:tableView, cellForRowAt:indexPath))
        //cell.button.addTarget(self, action: #selector(switchupCell(cell:cell)), for: .touchUpInside)
       // cell.button.addTarget(self, action: #selector(switchupCell), for: .touchUpInside)
        //cell.profileSettingLabel.text =
        //cell.profileSettingField.isHidden = false
        return cell
    }
    
    
    
    
    func connected(sender: TagButton){
        //print(sender.index)
        indexTap = sender.index
        tapEdit()
        //indexTap = sender.buttonTag
       // let buttonTag = sender.tag
        //let cell = tableView(_, cellForRowAt: buttonTag) as! ProfileSettingsCell
    
    }
    
    func tapEdit() {
        let tapCell = tableView.cellForRow(at: indexTap!) as! ProfileSettingsCell
        
        if (tapCell.profileSettingLabel.text?.contains("Email"))! {
            email = tapCell.profileSettingLabel.text!
        } else if (tapCell.profileSettingLabel.text?.contains("Username"))! {
            username = tapCell.profileSettingLabel.text!
        }
        
        if tapped == true {
            tapped = false
            //self.store.currentUser.
            //if tapCell.t
            if username != nil {
                tapCell.profileSettingLabel.text = username
            } else if email != nil {
                tapCell.profileSettingLabel.text = email
            }
            tapCell.profileSettingLabel.text = tapCell.profileSettingField.text!
            tapCell.profileSettingLabel.isHidden = false
            tapCell.profileSettingField.isHidden = true
        } else if tapped == false {
            tapped = true
            tapCell.profileSettingLabel.isHidden = true
            tapCell.profileSettingField.isHidden = false
        }
        
        //tapCell.backgroundColor = UIColor.blue
    }
    
//    class func switchupCell(cell:ProfileSettingsCell) {
//       // cell.profileSettingLabel.isHidden = true
//       // cell.profileSettingField.isHidden = false
//    }
////
    
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //tableView.tableHeaderView?.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        //tableView.selectio
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! ProfileSettingsCell
//        
//        cell.profileSettingField.delegate = self
//        cell.profileSettingLabel.isHidden = true
//        cell.profileSettingField.isHidden = false
//        //options[indexPath.row] = cell.profileSettingField.text!
//        //print("Index: \(options[indexPath.row])")
//       // print(cell.profileSettingField.text)
//        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:nowIndex];
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! ProfileSettingsCell
//        print("Index: \(options[indexPath.row])")
//        print(cell.profileSettingField.text)
//        options[indexPath.row] = cell.profileSettingField.text!
//        //guard let setting = options[indexPath.row] else { return }
//        cell.profileSettingLabel.text = options[indexPath.row]
//        print("Index: \(options[indexPath.row])")
//        print(cell.profileSettingField.text)
//        cell.profileSettingLabel.isHidden = false
//        cell.profileSettingField.isHidden = true
//        tableView.reloadData()
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func editButtonTapped() {
        tapped = true
        print("profile pic tapped\n\n\n\n\n\n")
    }
    
    
    
}
