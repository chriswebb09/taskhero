//
//  TaskListViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension TaskListViewController {
    
    // MARK: - TaskList UI
    
    func emptyTableViewState() {
        if (store.tasks.count < 1) && (!addTasksLabel.isHidden) {
            view.addSubview(addTasksLabel)
            addTasksLabel.center = self.view.center
            addTasksLabel.text = "No tasks have been added yet."
            addTasksLabel.translatesAutoresizingMaskIntoConstraints = false
            addTasksLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Profile.profileHeaderLabelHeight).isActive = true
            addTasksLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
            addTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if store.tasks.count < 1 {
            addTasksLabel.isHidden = false
        }
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
}
