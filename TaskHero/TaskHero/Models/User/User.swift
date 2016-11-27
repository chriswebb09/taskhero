//
//  User.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var uid: String
    var email: String
    var username: String
    var firstName: String?
    var lastName: String?
    var profilePicture: String?
    var experiencePoints: Int
    var level: String
    var joinDate: String
    var tasks: [Task]
    var numberOfTasksCompleted: Int
    
    required init(coder aDecoder: NSCoder) {
        uid = aDecoder.decodeObject(forKey:"UID") as! String
        email = aDecoder.decodeObject(forKey:"email") as! String
        firstName = aDecoder.decodeObject(forKey:"firstName") as? String
        lastName = aDecoder.decodeObject(forKey:"lastName") as? String
        username = aDecoder.decodeObject(forKey: "userName") as! String
        experiencePoints = aDecoder.decodeInteger(forKey: "Experience") 
        //experiencePoints = aDecoder.decodeObject(forKey:"ExperiencePoints") as! Int
        level = aDecoder.decodeObject(forKey:"level") as! String
        joinDate = aDecoder.decodeObject(forKey:"joinDate") as! String
        tasks = aDecoder.decodeObject(forKey:"tasks") as! [Task]
        numberOfTasksCompleted =  aDecoder.decodeInteger(forKey: "TasksCompleted")
        //profilePicture = aDecoder
        profilePicture = aDecoder.decodeObject(forKey: "ProfilePicture") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "userName")
        aCoder.encode(profilePicture, forKey: "profilePicture")
        aCoder.encode(uid, forKey: "UID")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(experiencePoints, forKey: "ExperiencePoints")
        aCoder.encode(level, forKey: "level")
        aCoder.encode(joinDate, forKey: "joinDate")
        aCoder.encode(numberOfTasksCompleted, forKey: "numberOfTasksCompleted")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(tasks, forKey: "tasks")
    }
    
    init(uid: String,  email: String, firstName: String?, lastName: String?, profilePicture: String, username: String, experiencePoints: Int, level: String, joinDate: String, tasks: [Task], numberOfTasksCompleted: Int) {
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName!
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
