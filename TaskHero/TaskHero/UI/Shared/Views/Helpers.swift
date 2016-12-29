//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


extension UITableView {
    func setupHelper() {
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.separatorStyle = .singleLine
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.allowsSelection = false
        self.rowHeight = UITableViewAutomaticDimension
    }
}


class LogoutHelper {
    func logoutButtonPressed(destinationViewController:UIViewController) {
        let destinationVC = UINavigationController(rootViewController:destinationViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = destinationVC
    }
}
