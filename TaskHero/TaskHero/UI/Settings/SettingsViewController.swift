//
//  SettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    let userSettings = ["Edit Profile", "Friends"]
    let applicationSettings = ["Notifications"]
    let segmentControl = UISegmentedControl(items: ["User Settings", "Application Settings"])
    var settings = [String]()
    let alertPop = AlertPopover()
    let notifyPop = NotificationPopover()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings = userSettings
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.backgroundColor() //UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        let header = UIView(frame:CGRect(x:0, y:0, width: Int(view.bounds.width), height: 50))
        header.backgroundColor = UIColor.white
        header.addSubview(segmentControl)
        tableView.tableHeaderView = header
        setupSegment()
        setupTableView()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        hide()
    }
    
}

extension SettingsViewController {

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if settings[indexPath.row] == "Edit Profile" {
            navigationController?.pushViewController(ProfileSettingsViewController(), animated: true)
        } else if settings[indexPath.row] == "Friends" {
            navigationController?.pushViewController(FriendsSettingsViewController(), animated: true)
        } else if settings[indexPath.row] == "Notifications" {
            notificationPopup()
        }
    }
    
}


extension SettingsViewController {
    

    func popup() {
        
        alertPop.popView.isHidden = false
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = 0
        alertPop.popView.layer.opacity = 0
        alertPop.showPopView(viewController: self)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.alertPop.popView.layer.opacity = 1
            self.alertPop.containerView.layer.opacity = 0.1
        })
        
        alertPop.popView.resultLabel.text = "Try Again Later."
        alertPop.popView.doneButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        alertPop.popView.cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    func notificationPopup() {
        
        notifyPop.popView.isHidden = false
        notifyPop.containerView.isHidden = false
        notifyPop.containerView.layer.opacity = 0
        notifyPop.popView.layer.opacity = 0
        notifyPop.showPopView(viewController: self)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.notifyPop.popView.layer.opacity = 1
            self.notifyPop.containerView.layer.opacity = 0.1
        })
        notifyPop.popView.doneButton.addTarget(self, action: #selector(dismissNotificationButton), for: .touchUpInside)
    }
    
    func dismissNotificationButton() {
        
        notifyPop.containerView.isHidden = true
        notifyPop.popView.isHidden = true
        notifyPop.hidePopView(viewController: self)
    }
    
    func dismissButton() {
        
        alertPop.containerView.isHidden = true
        alertPop.popView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
    
    func hide() {
        
        alertPop.containerView.isHidden = true
        alertPop.popView.isHidden = true
        alertPop.hidePopView(viewController: self)
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
        tableView.tableHeaderView?.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLineEtched
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func setupSegment() {
        
        let multipleAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.blue]
        let multipleUnselectedAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.black]
        
        segmentControl.tintColor = UIColor.white
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.layer.cornerRadius = 8
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.01).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.96).isActive = true
        segmentControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:Constants.loginFieldHeight).isActive = true
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
}
