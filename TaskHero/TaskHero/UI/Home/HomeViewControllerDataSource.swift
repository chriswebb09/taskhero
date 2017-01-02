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
   // let indentifier: String!
    
    func configure(indexPath:IndexPath, cellType:CellType) -> UITableViewCell {
        if cellType == .header {
            print("header")
            let headerCell = ProfileHeaderCell()
            
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
           // print("task")
            let taskCell = TaskCell()
            taskViewModel = TaskCellViewModel((self.store.currentUser.tasks?[indexPath.row])!)
            taskCell.configureCell(taskVM: taskViewModel)
            return taskCell
        }
        
//        else if cellType == .task {
//            
//        }
    }
    
//        if cellType.task(indexPath: indexPath) {
//            
//        }
//        
//        if cellType == .task(indexPath) {
//            var headerCell = TaskCell()
//            headerCell.configureCell(taskVM: cellType.taskCellViewModel, toggled: <#T##Bool#>)
//        }
    
    
    //var cellType = CellType.header
}



enum CellType {
    case task, header
}
//    
//    var taskCellViewModel: TaskCellViewModel {
//        switch(self) {
//        case .task(indexPath:IndexPath):
//            return TaskCellViewModel(self.store.currentUser.tasks[indexPath.row])
//        }
//    }
//}
