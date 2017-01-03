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
    
    init(taskID: String, taskName: String, taskDescription: String, taskCreated: String, taskDue: String, taskCompleted: Bool, pointValue:Int) {
        self.taskID = taskID
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskCreated = taskCreated
        self.taskDue = taskDue
        self.taskCompleted = taskCompleted
        self.pointValue = pointValue
    }
    
    init() {
        self.init(taskID: "", taskName: "", taskDescription:"", taskCreated:NSDate().dateWithFormat(), taskDue:"", taskCompleted:false, pointValue: 5)
    }
    
}


//extension Task {
//    class HelperClass: NSObject, NSCoding {
//        
//        var task: Task
//        
//        init(task:Task) {
//            self.task = task
//        }
//        
//        required init(coder aDecoder: NSCoder) {
//            self.task =  aDecoder.decodeObject(forKey: "TaskID") as! Task
//            self.task.taskID = aDecoder.decodeObject(forKey: "taskID") as! String
//            self.task.taskName = aDecoder.decodeObject(forKey: "taskName") as! String
//            self.task.taskDescription = aDecoder.decodeObject(forKey: "taskDescription") as! String
//            self.task.taskCreated = aDecoder.decodeObject(forKey: "taskCreated") as! String
//            self.task.taskDue = aDecoder.decodeObject(forKey: "taskDue") as! String
//            self.task.taskCompleted = aDecoder.decodeBool(forKey: "taskCompleted")
//            self.task.pointValue = aDecoder.decodeInteger(forKey: "pointValue")
//            super.init()
//        }
//        
//        
////        required init?(coder aDecoder: NSCoder) {
////            guard let taskID = aDecoder.decodeObject(forKey: "taskID") as? String else { return }
////            guard let taskName = aDecoder.decodeObject(forKey: "taskName") as? String else { return }
////            guard let taskDescription = aDecoder.decodeObject(forKey: "taskDescription") as? String else { return }
////            guard let taskCreated = aDecoder.decodeObject(forKey: "taskCreated") as? String else { return }
////            guard let taskDue = aDecoder.decodeObject(forKey: "taskDue") as? String else { return }
////            let taskCompleted = aDecoder.decodeBool(forKey: "taskCompleted")
////            let pointValue = aDecoder.decodeInteger(forKey: "pointValue")
////            task = Task(taskID: taskID, taskName: taskName, taskDescription: taskDescription, taskCreated: taskCreated, taskDue: taskDue, taskCompleted: taskCompleted, pointValue: pointValue)
////            super.init()
////        }
//        
//        public func encode(with aCoder: NSCoder) {
//            aCoder.encode(task.taskID, forKey:"taskID")
//            aCoder.encode(task.taskName, forKey:"taskName")
//            aCoder.encode(task.taskDescription, forKey:"taskDescription")
//            aCoder.encode(task.taskCreated, forKey:"taskCreated")
//            aCoder.encode(task.taskDue, forKey:"taskDue")
//            aCoder.encode(task.taskCompleted, forKey:"taskCompleted")
//            aCoder.encode(task.pointValue, forKey:"pointValue")
//        }
//        
//        
////        func encodeWithCoder(aCoder: NSCoder) {
////            aCoder.encode(task?.taskID, forKey:"taskID")
////            aCoder.encode(task?.taskName, forKey:"taskName")
////            aCoder.encode(task?.taskDescription, forKey:"taskDescription")
////            aCoder.encode(task?.taskCreated, forKey:"taskCreated")
////            aCoder.encode(task?.taskDue, forKey:"taskDue")
////            aCoder.encode(task?.taskCompleted, forKey:"taskCompleted")
////            aCoder.encode(task?.pointValue, forKey:"pointValue")
////        }
//    }

