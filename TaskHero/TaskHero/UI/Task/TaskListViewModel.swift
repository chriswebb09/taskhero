//
//  TaskListViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TaskListViewModel {
    
    let store = UserDataStore.sharedInstance
    
    var numberOfRows: Int {
        guard let tasks = store.currentUser.tasks else { return 0 }
        return tasks.count
    }
    
    var showTaskLabel: Bool {
        if store.tasks.count > 0 {
            print("tasks print \(self.store.tasks.count)")
            return false
        }
        return true
    }
    
    var taskLabelText: String {
        if showTaskLabel == true {
            return "No tasks have been added yet."
        }
        return ""
    }
    
    var taskLabelColor: UIColor = {
        return .lightGray
    }()
    
    let tableBackGroundColor: UIColor = {
        return Constants.Color.tableViewBackgroundColor
    }()
}
