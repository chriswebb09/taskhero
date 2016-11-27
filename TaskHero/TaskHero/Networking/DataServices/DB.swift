//
//  DB.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase


class Database {
    
    static let sharedInstance = Database()
    
    let store = DataStore.sharedInstance
    
    var dataSnapshot = [FIRDataSnapshot]()
    
    var dbRef: FIRDatabaseReference!
    var userRef: FIRDatabaseReference!
    var tasksRef: FIRDatabaseReference!
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    var auth = Auth()
    var fetch = DBFetch()
    
    deinit {
        self.ref.removeObserver(withHandle: self.refHandle)
    }
    
    init() {
        dbRef = FIRDatabase.database().reference()
        userRef = dbRef.child("Users")
        tasksRef = userRef
    }

    func insertUser(user:User) {
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints ?? 0,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted ?? 0]
        self.userRef.updateChildValues(["/\(self.store.currentUserString!)": userData])
    }

    func fetchTasks(completion:@escaping (_ task:Task) -> Void) {
        tasksRef = userRef.child(store.currentUserString).child("Tasks")
        refHandle = tasksRef.observe(.childAdded, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            //print(snapshotValue)
            var newTask = Task()
            newTask.taskID = snapshot.key
            print(newTask.taskID)
            if let fetchName = snapshotValue["TaskName"] as? String {
                newTask.taskName = fetchName
            }
            if let fetchDescription = snapshotValue["TaskDescription"] as? String {
                newTask.taskDescription = fetchDescription
            }
            if let fetchCreated = snapshotValue["TaskCreated"] as? String {
                newTask.taskCreated = fetchCreated
            }
            if let fetchDue = snapshotValue["TaskDue"] as? String {
                newTask.taskDue = fetchDue
            }
            if let fetchCompleted = snapshotValue["TaskCompleted"] as? Bool {
                newTask.taskCompleted = fetchCompleted
            }
            completion(newTask)
        })
    }
    
    func addTasks(task:Task) {
        tasksRef = userRef.child(store.currentUserString).child("Tasks")
        tasksRef.child("\(task.taskID)/TaskName").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/TaskDescription").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/TaskCreated").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/TaskDue").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/TaskCompleted").setValue(task.taskDue)
    }
    
    func removeTask(ref:String) {
        tasksRef = userRef.child(store.currentUserString).child("Tasks")
        tasksRef.child(ref).removeValue()
    }
}

