//
//  TaskCellViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/19/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TaskCellViewModel {
    var taskName:String
    var taskDescription:String
    var taskDue:String
    var taskCompleted: String
    
    init(_ task:Task) {
        self.taskName = task.taskName
        self.taskDescription = task.taskDescription
        self.taskDue = task.taskDue
        taskCompleted = task.taskCompleted.description
    }
}
