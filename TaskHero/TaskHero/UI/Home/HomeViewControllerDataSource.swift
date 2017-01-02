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
        return tasks
    }
    var indexPath: IndexPath!
    var autoHeight: UIViewAutoresizing?

    func configure(indexPath:IndexPath, cellType:CellType) -> UITableViewCell {
        if cellType == .header {
            print("header")
            let headerCell = ProfileHeaderCell()
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
            let taskCell = TaskCell()
            taskViewModel = TaskCellViewModel((self.store.currentUser.tasks?[indexPath.row])!)
            taskCell.configureCell(taskVM: taskViewModel)
            return taskCell
        }
    }
}



enum CellType {
    case task, header
}
