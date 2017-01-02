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


class Helpers {
    let store = DataStore.sharedInstance
    
    func getTasks(tableView: UITableView) {
        store.setupStore()
        store.firebaseAPI.fetchTasks() { task in
            self.store.tasks.append(task)
            self.store.currentUser.tasks?.append(task)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func removeRefHandle() {
        if self.store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }

    
}


