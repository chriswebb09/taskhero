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
    private var dbRef: FIRDatabaseReference!
    private var userRef: FIRDatabaseReference!
    var tasksRef: FIRDatabaseReference!
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    
    deinit {
        self.ref.removeObserver(withHandle: self.refHandle)
    }
    
    
    init() {
        
        self.dbRef = FIRDatabase.database().reference()
        self.userRef = self.dbRef.child("Users")
        self.tasksRef = self.userRef
    }
    
    func insertUser(user:User) {
        print(user)
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        print(userData)
        
        self.userRef.updateChildValues(["/\(self.store.currentUserString!)": userData])
    }
    
    
//    func updateUserScore(score:Int) {
//        let scoreData: NSDictionary = ["ExperiencePoints":score]
//        self.userRef.child("/\(self.store.currentUserString)").updateChildValues([scoreData])
//    }
//    
    func fetchTasks(completion:@escaping (_ task:Task) -> Void) {
        
        
        self.tasksRef = self.userRef.child(self.store.currentUserString).child("Tasks")
        self.refHandle = self.tasksRef.observe(.childAdded, with: { (snapshot) in
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
        self.tasksRef = self.userRef.child(self.store.currentUserString).child("Tasks")
        self.tasksRef.child("\(task.taskID)/TaskName").setValue(task.taskName)
        self.tasksRef.child("\(task.taskID)/TaskDescription").setValue(task.taskDescription)
        self.tasksRef.child("\(task.taskID)/TaskCreated").setValue(task.taskCreated)
        self.tasksRef.child("\(task.taskID)/TaskDue").setValue(task.taskDue)
        self.tasksRef.child("\(task.taskID)/TaskCompleted").setValue(task.taskDue)
    }
    
    
    func removeTask(ref:String) {
        self.tasksRef = self.userRef.child(self.store.currentUserString).child("Tasks")
        self.tasksRef.child(ref).removeValue()
    }
    
    
    func fetchUser(completion:@escaping (_ user:User) -> Void) {
        FIRDatabase.database().reference().child("Users").child(self.store.currentUserString).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                
                user.username = (dictionary["Username"] as? String)!
                user.email = (dictionary["Email"] as? String)!
                user.firstName =  dictionary["FirstName"] as? String
                user.lastName = dictionary["LastName"] as? String
                user.experiencePoints = (dictionary["ExperiencePoints"] as? Int)!
                user.level =  (dictionary["Level"] as? String)!
                user.joinDate = (dictionary["JoinDate"] as? String)!
                user.profilePicture = dictionary["ProfilePicture"] as? String
                user.numberOfTasksCompleted = (dictionary["TasksCompleted"] as? Int)!
                self.store.currentUser = user
            }
            
            
            }, withCancel: nil)
        
    }
}

