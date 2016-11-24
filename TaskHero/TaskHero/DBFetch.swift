//
//  DBFetch.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Firebase



class DBFetch {
    
    //let store = DataStore.sharedInstance
    
//    func fetchTask(with currentUserString: String, handler: @escaping (_ task:Task, _ handle:FIRDatabaseHandle) -> Void) {
//        let database = FIRDatabase.database()
//        let ref = database.reference()
//        let userRef = ref.child("Users")
//        let taskRef = userRef.child(currentUserString).child("Tasks")
//        var handle: FIRDatabaseHandle! = FIRDatabaseHandle()
//        handle = taskRef.observe(.childAdded, with: { snapshot in
//            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
//            var newTask = Task()
//            newTask.taskID = snapshot.key
//            print(newTask.taskID)
//            if let fetchName = snapshotValue["TaskName"] as? String {
//                newTask.taskName = fetchName
//            }
//            if let fetchDescription = snapshotValue["TaskDescription"] as? String {
//                newTask.taskDescription = fetchDescription
//            }
//            if let fetchCreated = snapshotValue["TaskCreated"] as? String {
//                newTask.taskCreated = fetchCreated
//            }
//            if let fetchDue = snapshotValue["TaskDue"] as? String {
//                newTask.taskDue = fetchDue
//            }
//            if let fetchCompleted = snapshotValue["TaskCompleted"] as? Bool {
//                newTask.taskCompleted = fetchCompleted
//            }
//            handler(newTask,handle)
//        })
//    }
    
        
//        database.reference().child("Users").child(currentUserString).observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
//            let user = User()
//            if let snapshotName = snapshotValue["Username"] as? String {
//                user.username = snapshotName
//            }
//            if let snapshotEmail = snapshotValue["Email"] as? String {
//                user.email = snapshotEmail
//            }
//            if let snapshotFirstName = snapshotValue["FirstName"] as? String {
//                user.firstName = snapshotFirstName
//            }
//            if let snapshotLastName = snapshotValue["LastName"] as? String {
//                user.lastName = snapshotLastName
//            }
//            if let snapshotLevel = snapshotValue["Level"] as? String {
//                user.level = snapshotLevel
//            }
//            if let snapshotJoinDate = snapshotValue["JoinDate"] as? String {
//                user.joinDate = snapshotJoinDate
//            }
//            if let snapshotProfilePicture = snapshotValue["ProfilePicture"] as? String {
//                user.profilePicture = snapshotProfilePicture
//            }
//            if let snapshotTasksCompleted = snapshotValue["TasksCompleted"] as? Int {
//                user.numberOfTasksCompleted = snapshotTasksCompleted
//            }
//            if let snapshotExperiencePoints = snapshotValue["ExperiencePoints"] as? Int {
//                user.experiencePoints = snapshotExperiencePoints
//            }
//            handler(user)
//        })

        
//        store.tasksRef = store.userRef.child(store.currentUserString).child("Tasks")
//        store.refHandle = store.tasksRef.observe(.childAdded, with: { (snapshot) in
//            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
//            var newTask = Task()
//            newTask.taskID = snapshot.key
//            print(newTask.taskID)
//            if let fetchName = snapshotValue["TaskName"] as? String {
//                newTask.taskName = fetchName
//            }
//            if let fetchDescription = snapshotValue["TaskDescription"] as? String {
//                newTask.taskDescription = fetchDescription
//            }
//            if let fetchCreated = snapshotValue["TaskCreated"] as? String {
//                newTask.taskCreated = fetchCreated
//            }
//            if let fetchDue = snapshotValue["TaskDue"] as? String {
//                newTask.taskDue = fetchDue
//            }
//            if let fetchCompleted = snapshotValue["TaskCompleted"] as? Bool {
//                newTask.taskCompleted = fetchCompleted
//            }
//            handler(newTask)
//        })
//    }
}

