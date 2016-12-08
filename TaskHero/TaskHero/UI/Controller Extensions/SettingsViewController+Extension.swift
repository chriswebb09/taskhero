//
//  SettingsViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


extension SettingsViewController {
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings = userSettings
            segmentControl.subviews[0].backgroundColor = UIColor.white
            dump(segmentControl)
        default:
            settings = applicationSettings
            segmentControl.subviews[1].backgroundColor = UIColor.white
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
        let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        let multipleUnselectedAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.black]
        segmentControl.layer.cornerRadius = Constants.Settings.segmentBorderRadius
        segmentControl.tintColor = UIColor.black
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.topAnchor.constraint(equalTo: (tableView.tableHeaderView?.topAnchor)!).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
       // segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:Constants.Settings.segmentSettingsWidth).isActive = true
        segmentControl.heightAnchor.constraint(equalTo:(tableView.tableHeaderView?.heightAnchor)!).isActive = true
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
        // segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * Constants.Settings.segmentSettingsTopOffset).isActive = true
        // segmentControl.heightAnchor.constraint(equalTo: tableView.tableHeaderView.heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        // let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        
    }
}


