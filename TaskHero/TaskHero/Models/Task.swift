//
//  Task.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class Task: NSObject {
    var taskID: String
    var taskName: String
    var taskDescription: String
    var taskDue: String
    var completed: Bool
    
    init(taskID: String, taskName:String, taskDescription: String, dueDate: String) {
        self.taskID = taskID
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskDue = dueDate
        self.completed = false
    }
    
    convenience override init() {
        self.init(taskID: "", taskName:"", taskDescription: "", dueDate: "")
    }
}
