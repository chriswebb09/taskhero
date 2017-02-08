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
        guard let tasks = store.currentUser.tasks else { return false }
        if tasks.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    var taskLabelText: String {
        if showTaskLabel == true {
            return "No tasks have been added yet."
        }
        return ""
    }
    
    var taskLabelColor: UIColor = {
        return UIColor.lightGray
    }()
    
    let tableBackGroundColor: UIColor = {
        return Constants.Color.tableViewBackgroundColor
    }()
}
