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
    var settingsViewModel:SettingsCellViewModel!
    
    // MARK: - Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = userSettings
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.NavBar.bottomHeight)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
        let header = UIView(frame:CGRect(x:0, y:0, width: Int(view.bounds.width), height: 50))
        header.backgroundColor = UIColor.white
        header.addSubview(segmentControl)
        tableView.tableHeaderView = header
        setupTableView()
        setupSegment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        hide()
    }
}

extension SettingsViewController {
    
    // MARK: UITableViewController Methods
    // =========================================================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier, for: indexPath as IndexPath) as! SettingsCell
        settingsViewModel = SettingsCellViewModel(settings[indexPath.row])
        settingsCell.configureCell(setting: settingsViewModel)
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
    
    // MARK: Public Methods
    // =========================================================================
    
    func launchPopupView() {
        alertPop.popView.layer.opacity = 0
        alertPop.popView.isHidden = false
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = 0
        alertPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1, animations: { self.alertPop.popView.layer.opacity = 1; self.alertPop.containerView.layer.opacity = 0.1 })
        alertPop.popView.resultLabel.text = "Try Again Later."
        alertPop.popView.doneButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        alertPop.popView.cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    // Displays popover when notifications cell is selected
    func notificationPopup() {
        notifyPop.popView.isHidden = false
        notifyPop.containerView.isHidden = false
        notifyPop.containerView.layer.opacity = 0
        notifyPop.popView.layer.opacity = 0
        notifyPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1, animations: { self.notifyPop.popView.layer.opacity = 1; self.notifyPop.containerView.layer.opacity = 0.1 })
        notifyPop.popView.doneButton.addTarget(self, action: #selector(dismissNotificationButton), for: .touchUpInside)
    }
    
    // MARK: - Setup buttons
    // =========================================================================
    
    // Hides notification popover
    
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
