//
//  SettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let userSettings = ["Username", "Email", "First Name", "Last Name", "Tasks Completed", "Friends"]
    let applicationSettings = ["Notifications", "Log Out", "Stay Logged In"]
    let segmentControl = UISegmentedControl(items: ["User Settings", "Application Settings"])
    var settings = [String]()
    let pop = PopMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = userSettings
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        
        let header = UIView(frame:CGRect(x:0, y:0, width: Int(view.bounds.width), height: 50))
        header.backgroundColor = UIColor.white
        //header.sizeThatFits(CGSize(width: view.bounds.width, height: 100))
        header.addSubview(segmentControl)
        
        //tableView.tableHeaderView?.clipsToBounds = true
        tableView.tableHeaderView = header
        //tableView.tableHeaderView?.backgroundColor = UIColor.white

        setupSegment()
        setupTableView()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideView))
//        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier, for: indexPath as IndexPath) as! SettingsCell
        settingsCell.contentView.clipsToBounds = true
        settingsCell.configureCell(setting: settings[indexPath.row])
        return settingsCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pop.popView.isHidden = false 
        pop.showPopView(viewController: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideView))
        pop.containerView.addGestureRecognizer(tap)
        
    }
    
    func hideView() {
        pop.popView.isHidden = true
        pop.hidePopView(viewController: self)
    }
}

extension SettingsViewController {
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings = userSettings
        default:
            settings = applicationSettings
        }
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView?.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func setupSegment() {
        let multipleAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.blue]
        let multipleUnselectedAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.lightGray]
        segmentControl.tintColor = UIColor.clear
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.layer.borderWidth = 1
        segmentControl.layer.borderColor = UIColor.gray.cgColor
        segmentControl.layer.cornerRadius = 8
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.01).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.96).isActive = true
        segmentControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:Constants.loginFieldHeight).isActive = true
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
}
