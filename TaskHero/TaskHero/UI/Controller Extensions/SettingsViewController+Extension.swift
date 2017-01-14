//
//  SettingsViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


extension SettingsViewController {
    
    // MARK: - Switch between segments
    
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
        }
        tableView.reloadData()
    }
    
    // MARK: - Segment Control UI
    
    func setupSegment() {
        let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        let multipleUnselectedAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.black]
        segmentControl.layer.cornerRadius = Constants.Settings.Segment.segmentBorderRadius
        segmentControl.tintColor = UIColor.black
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.topAnchor.constraint(equalTo: (tableView.tableHeaderView?.topAnchor)!).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalTo:(tableView.tableHeaderView?.heightAnchor)!).isActive = true
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
}


