//
//  APIClient.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class APIClient {
    
    // Firebase properties
    // =========================================================================
    
    let storage = FIRStorage.storage()
    var storageRef:FIRStorageReference!
    var tasksRef: FIRDatabaseReference!
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    var dataSnapshot = [FIRDataSnapshot]()
    var dbRef: FIRDatabaseReference!
    var imagesRef: FIRStorageReference!
    var userRef: FIRDatabaseReference!
    var usernameRef: FIRDatabaseReference!
    
    // App data properties
    // =========================================================================
    
    var validUsernames = [String]()
    var validUserData = [String]()
    var userData = Dictionary<String, AnyObject>()
    var usernameEmailDict = Dictionary<String, AnyObject>()
    var tasksDict = Dictionary<String, AnyObject>()
    
    
    init() {
        dbRef = FIRDatabase.database().reference()
        usernameRef = dbRef.child("Usernames")
    }
    
    // Initial firebase database reference properties
    // =========================================================================
    
    func setupRefs() {
        let userID = FIRAuth.auth()?.currentUser?.uid
        userRef = dbRef.child("Users").child(userID!)
        tasksRef = userRef.child("Tasks")
    }
    
    // Fetch all valid usernames in database
    // =========================================================================
    
    func fetchValidUsernames() {
        validUsernames.removeAll()
        usernameRef.observe(.childAdded, with: { snapshot in
            self.validUsernames.append(snapshot.key)
            self.usernameEmailDict[snapshot.key] = snapshot.value as AnyObject?
        })
    }
    
    // Fetch user profile data store in realtime database return data in completion
    // =========================================================================
    
    func fetchUser(completion:@escaping (User)-> ()) {
        let database = FIRDatabase.database()
        let uid = FIRAuth.auth()?.currentUser?.uid
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(uid)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        database.reference().child("Users").child(uid!).observe(.value, with: { snapshot in
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
            
            completion(user)
        })
    }
    
    // Add new user profile to realtime database
    // =========================================================================
    
    func insertUser(user:User) {
        let uid = user.uid
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints ,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        userRef.updateChildValues(["/\(uid)": userData])
        userRef.keepSynced(true)
        usernameRef.updateChildValues([user.username:user.email])
    }
    
    // Fetch user profile data from realtime database
    // =========================================================================
    
    
    func fetchUserData() {
        let userID = FIRAuth.auth()?.currentUser?.uid
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(userID)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        userRef.child(userID!).observe(.childAdded, with: { (snapshot) in
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
        })
    }
    
    // Grab tasks from user profile in realtime user database
    // =========================================================================
    
    func fetchTasks(completion:@escaping (_ task:Task) -> Void) {
        tasksRef.keepSynced(true)
        refHandle = tasksRef.observe(.childAdded, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
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
    
    // Adds new task to database - called from all viewcontrollers except popovers and addtaskviewcontroller
    // =========================================================================
    
    func addTasks(task:Task) {
        tasksRef.child("\(task.taskID)/TaskName").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/TaskDescription").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/TaskCreated").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/TaskDue").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/TaskCompleted").setValue(task.taskDue)
        tasksRef.keepSynced(true)
    }
    
    
    // Removes task from database - called on swift left in tableview
    // =========================================================================
    
    func removeTask(ref:String, taskID: String) {
        tasksRef.child(ref).removeValue()
    }
    
    func updateTask(ref:String, taskID: String, task:Task) {
        let taskData: NSDictionary = ["TaskName": task.taskName,
                                      "TaskDescription": task.taskDescription ,
                                      "TaskCreated": task.taskCreated ,
                                      "TaskDue": task.taskDue,
                                      "TaskCompleted": task.taskCompleted]
        tasksRef.updateChildValues(["/\(taskID)": taskData])
    }
    
    // Updates user profile data in database
    // =========================================================================
    
    func updateUserProfile(userID: String, user:User) {
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        userRef.updateChildValues(["/\(userID)": userData])
        userRef.keepSynced(true)
        usernameRef.updateChildValues([user.username:user.email])
    }
    
    
    func uploadImage(profilePicture:UIImage, user:User, completion:@escaping(_ url:String) ->()) {
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(profilePicture) {
            storageRef.put(uploadData, metadata: nil, completion: { metadata, error in
                if error != nil {
                    print(error ?? "Unable to get specific error")
                    return
                }
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    print("\n\n")
                    print(profileImageUrl)
                    completion(profileImageUrl)
                    
                }
            })
            
        }
        
        
    }
    
}
