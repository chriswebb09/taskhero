//
//  SettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    let applicationSettings = ["Notifications"]
    let userSettings = ["Edit Profile", "Friends"]
    let segmentControl = UISegmentedControl(items: ["User Settings", "Application Settings"])
    let label = UILabel()
    var settings = [String]()
    let alertPop = AlertPopover()
    let notifyPop = NotificationPopover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = userSettings
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.backgroundColor() //UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
        let header = UIView(frame:CGRect(x:0, y:0, width: Int(view.bounds.width), height: 50))
        header.backgroundColor = UIColor.white
        header.addSubview(segmentControl)
        tableView.tableHeaderView = header
        setupTableView()
        setupSegment()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier, for: indexPath as IndexPath) as! SettingsCell
        settingsCell.configureCell(setting: settings[indexPath.row])
        settingsCell.contentView.clipsToBounds = true
        return settingsCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settings[indexPath.row] == "Edit Profile" { navigationController?.pushViewController(ProfileSettingsViewController(), animated: true) }
        else if settings[indexPath.row] == "Friends" { navigationController?.pushViewController(FriendsSettingsViewController(), animated: true) }
        else if settings[indexPath.row] == "Notifications" { notificationPopup() }
    }
}

extension SettingsViewController {
    
    func launchPopupView() {
        alertPop.popView.layer.opacity = 0
        alertPop.popView.isHidden = false
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = 0
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
        }); notifyPop.popView.doneButton.addTarget(self, action: #selector(dismissNotificationButton), for: .touchUpInside)
    }
    
    func dismissNotificationButton() {
        notifyPop.popView.isHidden = true
        notifyPop.containerView.isHidden = true
        notifyPop.hidePopView(viewController: self)
    }
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
}

extension SettingsViewController {
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings = userSettings
            segmentControl.subviews[1].backgroundColor = UIColor.lightGray
            dump(segmentControl)
        default:
            settings = applicationSettings
            segmentControl.subviews[0].backgroundColor = UIColor.lightGray
            dump(segmentControl)
        }; tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = Constants.Settings.rowHeight
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .singleLineEtched
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView?.backgroundColor = UIColor.white
    }
    
    func setupSegment() {
        let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.black]
        let multipleUnselectedAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.black]
        segmentControl.layer.cornerRadius = Constants.Settings.segmentBorderRadius
        segmentControl.tintColor = UIColor.white
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.topAnchor.constraint(equalTo: (tableView.tableHeaderView?.topAnchor)!).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:Constants.Settings.segmentSettingsWidth).isActive = true
        segmentControl.heightAnchor.constraint(equalTo:(tableView.tableHeaderView?.heightAnchor)!).isActive = true
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
        // segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * Constants.Settings.segmentSettingsTopOffset).isActive = true
        // segmentControl.heightAnchor.constraint(equalTo: tableView.tableHeaderView.heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        // let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        
    }
}


