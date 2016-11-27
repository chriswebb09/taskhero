//
//  User.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

import UIKit

class User: NSObject {
    
    var uid: String
    var email: String
    var username: String
    var firstName: String?
    var lastName: String?
    var profilePicture: String?
    var experiencePoints: Int
    var level: String
    var joinDate: String
    var tasks: [Task]?
    var numberOfTasksCompleted: Int
    
    init(uid: String,  email: String, firstName: String?, lastName: String?, profilePicture: String?, username: String, experiencePoints: Int, level: String, joinDate: String, tasks: [Task]?, numberOfTasksCompleted: Int) {
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.experiencePoints = experiencePoints
        self.level = level
        self.joinDate = joinDate
        self.tasks = tasks
        self.numberOfTasksCompleted = numberOfTasksCompleted
        super.init()
    }
    
    override convenience init() {
        self.init(uid:" ", email:" ", firstName: " ", lastName:" ", profilePicture: "None", username: " ", experiencePoints: 0, level: "Task Goat", joinDate: NSDate().dateWithFormat(), tasks:[Task](), numberOfTasksCompleted: 0)
    }
}

