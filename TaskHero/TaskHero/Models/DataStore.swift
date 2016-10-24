//
//  DataStore.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class DataStore {
    
    var currentUser: User!
    var currentUserString: String!
    var tasks = [Task]()
    
    static let sharedInstance = DataStore()
    
    var tasksRef: FIRDatabaseReference!
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    var validUsernames = [String]()
    var validUserData = [String]()
    var userData = Dictionary<String, AnyObject>()
    var usernameEmailDict = Dictionary<String, AnyObject>()
    var tasksDict = Dictionary<String, AnyObject>()
    var dataSnapshot = [FIRDataSnapshot]()
    var dbRef: FIRDatabaseReference!
    var userRef: FIRDatabaseReference!
    var usernameRef: FIRDatabaseReference!

    deinit {
        self.ref.removeObserver(withHandle: self.refHandle)
    }
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        self.userRef = self.dbRef.child("Users")
        self.usernameRef = self.dbRef.child("Usernames")
        self.tasksRef = self.userRef
    }
    
    func fetchValidUsernames() {
        validUsernames.removeAll()
        usernameRef.observe(.childAdded, with: { (snapshot) in
            self.validUsernames.append(snapshot.key)
            self.usernameEmailDict[snapshot.key] = snapshot.value as AnyObject?
           //print (self.userDataDict)
            //print (self.validUsernames)
        })
    }
    
    func fetchUserData() {
        userRef.child(currentUserString!).observe(.childAdded, with: { (snapshot) in
            //self.validUserData.append(snapshot.key)
            self.userData[snapshot.key] = snapshot.value as AnyObject?
            let user = User()
            if let snapshotName = self.userData["Username"] as? String {
                user.username = snapshotName
            }
            if let snapshotEmail = self.userData["Email"] as? String {
                user.email = snapshotEmail
            }
            if let snapshotFirstName = self.userData["FirstName"] as? String {
                user.firstName = snapshotFirstName
            }
            if let snapshotLastName = self.userData["LastName"] as? String {
                user.lastName = snapshotLastName
            }
            if let snapshotLevel = self.userData["Level"] as? String {
                user.level = snapshotLevel
            }
            if let snapshotJoinDate = self.userData["JoinDate"] as? String {
                user.joinDate = snapshotJoinDate
            }
            if let snapshotProfilePicture = self.userData["ProfilePicture"] as? String {
                user.profilePicture = snapshotProfilePicture
            }
            if let snapshotTasksCompleted = self.userData["TasksCompleted"] as? Int {
                user.numberOfTasksCompleted = snapshotTasksCompleted
            }
            if let snapshotExperiencePoints = self.userData["ExperiencePoints"] as? Int {
                user.experiencePoints = snapshotExperiencePoints
            }
            
            self.currentUser = user
            
        })
    }
    
    
//    func fetchUserData() {
//        
//        userRef.child(currentUserString!).observe(.childAdded, with: { (snapshot) in
//            //self.validUserData.append(snapshot.key)
//            self.userData[snapshot.key] = snapshot.value as AnyObject?
//            let user = User()
//            if let snapshotName = self.userData["Username"] as? String {
//                user.username = snapshotName
//            }
//            if let snapshotEmail = self.userData["Email"] as? String {
//                user.email = snapshotEmail
//            }
//            if let snapshotFirstName = self.userData["FirstName"] as? String {
//                user.firstName = snapshotFirstName
//            }
//            if let snapshotLastName = self.userData["LastName"] as? String {
//                user.lastName = snapshotLastName
//            }
//            if let snapshotLevel = self.userData["Level"] as? String {
//                user.level = snapshotLevel
//            }
//            if let snapshotJoinDate = self.userData["JoinDate"] as? String {
//                user.joinDate = snapshotJoinDate
//            }
//            if let snapshotProfilePicture = self.userData["ProfilePicture"] as? String {
//                user.profilePicture = snapshotProfilePicture
//            }
//            if let snapshotTasksCompleted = self.userData["TasksCompleted"] as? Int {
//                user.numberOfTasksCompleted = snapshotTasksCompleted
//            }
//            if let snapshotExperiencePoints = self.userData["ExperiencePoints"] as? Int {
//                user.experiencePoints = snapshotExperiencePoints
//            }
//            
//            self.currentUser = user
//            
//        })
//    }

    
    
    func fetchUserTasks() {
        //userRef.child(currentUserString!).child(<#T##pathString: String##String#>)
            //.observe(.childAdded, with: { (snapshot) in
        self.tasks.removeAll()
        self.tasksRef = self.userRef.child(self.currentUserString).child("Tasks")
        self.refHandle = self.tasksRef.observe(.childAdded, with: { (snapshot) in
            self.tasksDict[snapshot.key] = snapshot.value as AnyObject?
            //guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            var newTask = Task()
            
            newTask.taskID = snapshot.key
            
            if let fetchName = self.tasksDict["TaskName"] as? String {
                newTask.taskName = fetchName
            }
            
            if let fetchDescription = self.tasksDict["TaskDescription"] as? String {
                newTask.taskDescription = fetchDescription
            }
            if let fetchCreated = self.tasksDict["TaskCreated"] as? String {
                newTask.taskCreated = fetchCreated
            }
            if let fetchDue = self.tasksDict["TaskDue"] as? String {
                newTask.taskDue = fetchDue
            }
            if let fetchCompleted = self.tasksDict["TaskCompleted"] as? Bool {
                newTask.taskCompleted = fetchCompleted
            }
            self.tasks.insert(newTask, at:0)
        })

    }
    
    
    
    
    //func fetchValidUsernames() {
    //    validUsernames.removeAll()
   //     usersRef.observe(.childAdded, with: { (snapshot) in
   //         self.validUsernames.append(snapshot.key)
  //          self.userDataDict[snapshot.key] = snapshot.value as AnyObject?
 //           print (self.userDataDict)
 //           print (self.validUsernames)
 //       })
  //  }
    
    //func insertUsername() {
    //    print(FIRAuth.auth()?.currentUser?.displayName)
     //   let userData: NSDictionary = [FIRAuth.auth()?.currentUser?.uid:FIRAuth.auth()?.currentUser?.email]
    //    self.usernameRef.updateChildValues([(FIRAuth.auth()?.currentUser?.displayName)!:userData])
   // }
    
    func insertUser(user:User) {
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        self.userRef.updateChildValues(["/\(self.currentUserString!)": userData])
        self.usernameRef.updateChildValues([user.username:user.email])
    }
    
    
    func fetchUser(completion:@escaping (User)-> ()) {
        let database = FIRDatabase.database()
        database.reference().child("Users").child(self.currentUserString).observeSingleEvent(of: .value, with: { (snapshot) in
            //guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            let user = User()
            if let snapshotName = snapshotValue["Username"] as? String {
                user.username = snapshotName
            }
            if let snapshotEmail = snapshotValue["Email"] as? String {
                user.email = snapshotEmail
            }
            if let snapshotFirstName = snapshotValue["FirstName"] as? String {
                user.firstName = snapshotFirstName
            }
            if let snapshotLastName = snapshotValue["LastName"] as? String {
                user.lastName = snapshotLastName
            }
            if let snapshotLevel = snapshotValue["Level"] as? String {
                user.level = snapshotLevel
            }
            if let snapshotJoinDate = snapshotValue["JoinDate"] as? String {
                user.joinDate = snapshotJoinDate
            }
            if let snapshotProfilePicture = snapshotValue["ProfilePicture"] as? String {
                user.profilePicture = snapshotProfilePicture
            }
            if let snapshotTasksCompleted = snapshotValue["TasksCompleted"] as? Int {
                user.numberOfTasksCompleted = snapshotTasksCompleted
            }
            if let snapshotExperiencePoints = snapshotValue["ExperiencePoints"] as? Int {
                user.experiencePoints = snapshotExperiencePoints
            }
            print(user)
            self.currentUser = user
            completion(user)
        })
    }
    
    
    func fetchTasks(completion:@escaping (_ task:Task) -> Void) {
        self.tasksRef = self.userRef.child(self.currentUserString).child("Tasks")
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
        self.tasksRef = self.userRef.child(self.currentUserString!).child("Tasks")
        self.tasksRef.child("\(task.taskID)/TaskName").setValue(task.taskName)
        self.tasksRef.child("\(task.taskID)/TaskDescription").setValue(task.taskDescription)
        self.tasksRef.child("\(task.taskID)/TaskCreated").setValue(task.taskCreated)
        self.tasksRef.child("\(task.taskID)/TaskDue").setValue(task.taskDue)
        self.tasksRef.child("\(task.taskID)/TaskCompleted").setValue(task.taskDue)
    }
    
    func removeTask(ref:String) {
        self.tasksRef = self.userRef.child(self.currentUserString).child("Tasks")
        self.tasksRef.child(ref).removeValue()
    }

}
