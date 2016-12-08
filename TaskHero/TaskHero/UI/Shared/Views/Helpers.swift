//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TabviewHelper {
    
    func setupTableView(tableView: UITableView) {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
       // tableView.estimatedRowHeight = view.frame.height / 4
    }
}

class LogoutHelper {
    func logoutButtonPressed(destinationViewController:UIViewController) {
        let destinationVC = UINavigationController(rootViewController:destinationViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = destinationVC
    }
}
