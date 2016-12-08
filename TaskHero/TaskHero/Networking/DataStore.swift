
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
    
    static let sharedInstance = DataStore()
    var currentUser: User!
    var currentUserString: String!
    var tasks = [Task]()
    let storage = FIRStorage.storage()
    var storageRef:FIRStorageReference!
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
    var imagesRef: FIRStorageReference!
    var userRef: FIRDatabaseReference!
    var usernameRef: FIRDatabaseReference!
    var auth = Auth()
    
    // MARK: Deinit
    // Removes refhandle
    
    deinit {
        ref.removeObserver(withHandle: refHandle)
    }
    
    init() {
        storageRef = storage.reference(forURL: "gs://taskhero-d3fd7.appspot.com")
        imagesRef = storageRef.child("images")
        dbRef = FIRDatabase.database().reference()
        userRef = dbRef.child("Users")
        usernameRef = dbRef.child("Usernames")
        tasksRef = userRef
    }
    
    func uploadImages() {
        
    }
    
    func downloadImages() {
        
    }
    
    func fetchUserData() {
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(self.currentUserString)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        userRef.child(currentUserString!).observe(.childAdded, with: { (snapshot) in
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
    
    // MARK: - fetches all usernames in database and adds them to array
    
    // TODO: needs revamping - wouldn't scale well
    
    func fetchValidUsernames() {
        validUsernames.removeAll()
        usernameRef.observe(.childAdded, with: { snapshot in
            self.validUsernames.append(snapshot.key)
            self.usernameEmailDict[snapshot.key] = snapshot.value as AnyObject?
        })
    }
    
    // Inserts new user to database and updates usernames keys
    
    func insertUser(user:User) {
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints ,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        userRef.updateChildValues(["/\(self.currentUserString!)": userData])
        userRef.keepSynced(true)
        usernameRef.updateChildValues([user.username:user.email])
    }
    
    func fetchUser(completion:@escaping (User)-> ()) {
        let database = FIRDatabase.database()
        guard let uid = currentUserString else { return }
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(uid)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        database.reference().child("Users").child(uid).observe(.value, with: { snapshot in
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
        let userID = FIRAuth.auth()?.currentUser?.uid
        tasksRef = userRef.child((userID)!).child("Tasks")
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
    
    func addTasks(task:Task) {
        tasksRef = userRef.child(currentUserString!).child("Tasks")
        tasksRef.child("\(task.taskID)/TaskName").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/TaskDescription").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/TaskCreated").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/TaskDue").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/TaskCompleted").setValue(task.taskDue)
        tasksRef.keepSynced(true)
    }
    
    // Removes task from database - called on swift left in tableview
    
    func removeTask(ref:String, taskID: String) {
        tasksRef = userRef.child(currentUserString).child("Tasks")
        tasksRef.child(ref).removeValue()
    }
    
    func updateTask(ref:String, taskID: String, task:Task) {
        tasksRef = userRef.child(currentUserString).child("Tasks")
        let taskData: NSDictionary = ["TaskName": task.taskName,
                                      "TaskDescription": task.taskDescription ,
                                      "TaskCreated": task.taskCreated ,
                                      "TaskDue": task.taskDue,
                                      "TaskCompleted": task.taskCompleted]
        tasksRef.updateChildValues(["/\(taskID)": taskData])
    }
    
    // Updates user profile data in database
    
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
        userRef.updateChildValues(["/\(self.currentUserString!)": userData])
        userRef.keepSynced(true)
        usernameRef.updateChildValues([user.username:user.email])
        self.tasks.forEach { task in
            updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
}
