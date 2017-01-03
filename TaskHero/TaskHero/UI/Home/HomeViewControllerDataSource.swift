//
//  HomeViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class HomeViewControllerDataSource {
    let store = DataStore.sharedInstance
    fileprivate var taskViewModel: TaskCellViewModel!
    var rows: Int! {
        guard let tasks = store.currentUser.tasks?.count else { return 0 }
        if tasks < 1 {
            return 1
        } else {
            return tasks + 1
        }
    }
    
    var indexPath: IndexPath!
    var autoHeight: UIViewAutoresizing?
}

extension HomeViewControllerDataSource {
    
    func configure(indexPath:IndexPath, cellType:HomeCellType) -> UITableViewCell {
        if cellType == .header {
            print("header")
            let headerCell = ProfileHeaderCell()
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
            let taskCell = TaskCell()
            taskViewModel = TaskCellViewModel((self.store.currentUser.tasks?[indexPath.row - 1])!)
            taskCell.configureCell(taskVM: taskViewModel)
            return taskCell
        }
    }
    
    func setupView(tableView:UITableView, view: UIView) {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.setupHelper()
        tableView.estimatedRowHeight = view.frame.height / 4
    }
}

enum HomeCellType {
    case task, header
}
