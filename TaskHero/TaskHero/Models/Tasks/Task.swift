//
//  Task.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class Task: NSObject, NSCoding {
    
    var taskID: String
    var taskName: String
    var taskDescription:String
    var taskCreated: String
    var taskDue: String
    var taskCompleted: Bool
    var pointValue: Int
    
    required init(coder aDecoder: NSCoder) {
        taskID = aDecoder.decodeObject(forKey:"taskID") as! String
        taskName = aDecoder.decodeObject(forKey:"taskName") as! String
        taskDescription = aDecoder.decodeObject(forKey:"taskDescription") as! String
        taskCreated = aDecoder.decodeObject(forKey:"taskCreated") as! String
        taskDue = aDecoder.decodeObject(forKey:"taskDue") as! String
        taskCompleted = aDecoder.decodeObject(forKey:"taskCompleted") as! Bool
        pointValue = aDecoder.decodeObject(forKey:"pointValue") as! Int
//        uid = aDecoder.decodeObject(forKey:"UID") as! String
//        email = aDecoder.decodeObject(forKey:"email") as! String
//        firstName = aDecoder.decodeObject(forKey:"firstName") as? String
//        lastName = aDecoder.decodeObject(forKey:"lastName") as? String
//        username = aDecoder.decodeObject(forKey: "userName") as! String
//        experiencePoints = aDecoder.decodeObject(forKey:"experiencePoints") as! Int
//        level = aDecoder.decodeObject(forKey:"level") as! String
//        joinDate = aDecoder.decodeObject(forKey:"joinDate") as! String
//        tasks = aDecoder.decodeObject(forKey:"tasks") as? [Task]
//        numberOfTasksCompleted = aDecoder.decodeObject(forKey:"numberOfTasksCompleted") as! Int
//        profilePicture = aDecoder.decodeObject(forKey: "profilePicture") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskID, forKey: "taskID")
        aCoder.encode(taskName, forKey: "taskName")
        aCoder.encode(taskDescription, forKey: "taskDescription")
        aCoder.encode(taskCreated, forKey: "taskCreated")
        aCoder.encode(taskDue, forKey: "taskDue")
        aCoder.encode(taskCompleted, forKey: "taskCompleted")
        aCoder.encode(pointValue, forKey: "pointValue")
//        aCoder.encode(username, forKey: "userName")
//        aCoder.encode(profilePicture, forKey: "profilePicture")
//        aCoder.encode(uid, forKey: "UID")
//        aCoder.encode(email, forKey: "email")
//        aCoder.encode(experiencePoints, forKey: "experiencePoints")
//        aCoder.encode(level, forKey: "level")
//        aCoder.encode(joinDate, forKey: "joinDate")
//        aCoder.encode(numberOfTasksCompleted, forKey: "numberOfTasksCompleted")
//        aCoder.encode(firstName, forKey: "firstName")
//        aCoder.encode(lastName, forKey: "lastName")
//        aCoder.encode(tasks, forKey: "tasks")
    }
    
    init(taskID: String, taskName: String, taskDescription: String, taskCreated: String, taskDue: String, taskCompleted: Bool, pointValue:Int) {
        self.taskID = taskID
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskCreated = taskCreated
        self.taskDue = taskDue
        self.taskCompleted = taskCompleted
        self.pointValue = pointValue
    }
    
    convenience override init() {
        self.init(taskID: "", taskName: "", taskDescription:"", taskCreated:NSDate().dateWithFormat(), taskDue:"", taskCompleted:false, pointValue: 5)
    }
    
}
