//
//  Task.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit

struct Task {
    var taskID: String
    var taskName: String
    var taskDescription:String
    var taskCreated: String
    var taskDue: String
    var taskCompleted: Bool
    var pointValue: Int
}

extension Task {
    init() {
        self.init(taskID: "", taskName: "", taskDescription:"", taskCreated:NSDate().dateWithFormat(), taskDue:"", taskCompleted:false, pointValue: 5)
    }
}
