//
//  APIClient.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import Firebase

typealias TaskCompletion = (Task) -> Void
typealias UserCompletion = (User) -> Void

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
    
    func fetchUser(completion:@escaping UserCompletion) {
        let database = FIRDatabase.database()
        let uid = FIRAuth.auth()?.currentUser?.uid
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(uid)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        database.reference().child("Users").child(uid!).observe(.value, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            let user = User()
            if let snapshotName = snapshotValue[Constants.API.username] as? String {
                user.username = snapshotName
            }
            if let snapshotEmail = snapshotValue[Constants.API.email] as? String {
                user.email = snapshotEmail
            }
            if let snapshotFirstName = snapshotValue[Constants.API.firstName] as? String {
                user.firstName = snapshotFirstName
            }
            if let snapshotLastName = snapshotValue[Constants.API.lastName] as? String {
                user.lastName = snapshotLastName
            }
            if let snapshotLevel = snapshotValue[Constants.API.level] as? String {
                user.level = snapshotLevel
            }
            if let snapshotJoinDate = snapshotValue[Constants.API.joinDate] as? String {
                user.joinDate = snapshotJoinDate
            }
            if let snapshotProfilePicture = snapshotValue[Constants.API.profilePicture] as? String {
                user.profilePicture = snapshotProfilePicture
            }
            if let snapshotTasksCompleted = snapshotValue[Constants.API.tasksCompleted] as? Int {
                user.numberOfTasksCompleted = snapshotTasksCompleted
            }
            if let snapshotExperiencePoints = snapshotValue[Constants.API.experiencePoints] as? Int {
                user.experiencePoints = snapshotExperiencePoints
            }
            
            completion(user)
        })
    }
    
    // Add new user profile to realtime database
    // =========================================================================
    
    func insertUser(user:User) {
        let uid = user.uid
        let userData: NSDictionary = [Constants.API.email: user.email,
                                      Constants.API.firstName: user.firstName ?? " ",
                                      Constants.API.lastName: user.lastName ?? " ",
                                      Constants.API.profilePicture: user.profilePicture ?? " ",
                                      Constants.API.experiencePoints: user.experiencePoints ,
                                      Constants.API.level: user.level,
                                      Constants.API.joinDate: user.joinDate,
                                      Constants.API.username: user.username,
                                      Constants.API.tasksCompleted: user.numberOfTasksCompleted]
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
        userRef.child(userID!).observe(.childAdded, with: { snapshot in
            self.userData[snapshot.key] = snapshot.value as AnyObject?
            let user = User()
            if let snapshotName = self.userData[Constants.API.username] as? String {
                user.username = snapshotName
            }
            if let snapshotEmail = self.userData[Constants.API.email] as? String {
                user.email = snapshotEmail
            }
            if let snapshotFirstName = self.userData[Constants.API.firstName] as? String {
                user.firstName = snapshotFirstName
            }
            if let snapshotLastName = self.userData[Constants.API.lastName] as? String {
                user.lastName = snapshotLastName
            }
            if let snapshotLevel = self.userData[Constants.API.level] as? String {
                user.level = snapshotLevel
            }
            if let snapshotJoinDate = self.userData[Constants.API.joinDate] as? String {
                user.joinDate = snapshotJoinDate
            }
            if let snapshotProfilePicture = self.userData[Constants.API.profilePicture] as? String {
                user.profilePicture = snapshotProfilePicture
            }
            if let snapshotTasksCompleted = self.userData[Constants.API.tasksCompleted] as? Int {
                user.numberOfTasksCompleted = snapshotTasksCompleted
            }
            if let snapshotExperiencePoints = self.userData[Constants.API.experiencePoints] as? Int {
                user.experiencePoints = snapshotExperiencePoints
            }
        })
    }
    
    // Grab tasks from user profile in realtime user database
    // =========================================================================
    
    func fetchTasks(completion:@escaping TaskCompletion) {
        tasksRef.keepSynced(true)
        refHandle = tasksRef.observe(.childAdded, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            var newTask = Task()
            newTask.taskID = snapshot.key
            print(newTask.taskID)
            if let fetchName = snapshotValue[Constants.API.Task.taskName] as? String {
                newTask.taskName = fetchName
            }
            if let fetchDescription = snapshotValue[Constants.API.Task.taskDescription] as? String {
                newTask.taskDescription = fetchDescription
            }
            if let fetchCreated = snapshotValue[Constants.API.Task.taskCreated] as? String {
                newTask.taskCreated = fetchCreated
            }
            if let fetchDue = snapshotValue[Constants.API.Task.taskDue] as? String {
                newTask.taskDue = fetchDue
            }
            if let fetchCompleted = snapshotValue[Constants.API.Task.taskCompleted] as? Bool {
                newTask.taskCompleted = fetchCompleted
            }
            completion(newTask)
        })
    }
    
    // Adds new task to database - called from all viewcontrollers except popovers and addtaskviewcontroller
    // =========================================================================
    
    func addTasks(task:Task) {
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskName)").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDescription)").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCreated)").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDue)").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCompleted)").setValue(task.taskCompleted)
        tasksRef.keepSynced(true)
    }
    
    
    // Removes task from database - called on swift left in tableview
    // =========================================================================
    
    func removeTask(ref:String, taskID: String) {
        tasksRef.child(ref).removeValue()
    }
    
    func updateTask(ref:String, taskID: String, task:Task) {
        let taskData: NSDictionary = [Constants.API.Task.taskName: task.taskName,
                                      Constants.API.Task.taskDescription: task.taskDescription ,
                                      Constants.API.Task.taskCreated: task.taskCreated ,
                                      Constants.API.Task.taskDue: task.taskDue,
                                      Constants.API.Task.taskCompleted: task.taskCompleted]
        tasksRef.updateChildValues(["/\(taskID)": taskData])
    }
    
    // Updates user profile data in database
    // =========================================================================
    
    func updateUserProfile(userID: String, user:User) {
        let userData: NSDictionary = [Constants.API.email: user.email,
                                      Constants.API.firstName: user.firstName ?? " ",
                                      Constants.API.lastName: user.lastName ?? " ",
                                      Constants.API.profilePicture: user.profilePicture ?? " ",
                                      Constants.API.experiencePoints: user.experiencePoints ,
                                      Constants.API.level: user.level,
                                      Constants.API.joinDate: user.joinDate,
                                      Constants.API.username: user.username,
                                      Constants.API.tasksCompleted: user.numberOfTasksCompleted]
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
    
    func registerUser(user:User) {
        self.ref = FIRDatabase.database().reference()
        self.userRef = dbRef.child("Users").child(user.uid)
        let usernameRefs = ref.child("Usernames")
        let usernameValues = [user.username:user.email] as [String : Any] as NSDictionary
        usernameRefs.updateChildValues(usernameValues as! [AnyHashable : Any]) { err, ref in
            if err != nil {
                print(err ?? "unable to get specific error i")
                return
            }
        }
        
       // let values = ["Username": user.username, "Email": user.email, "FirstName": user.firstName!, "LastName": user.lastName!, "ProfilePicture": user.profilePicture!, "ExperiencePoints": user.experiencePoints, "Level": user.level, "JoinDate":user.joinDate, "TasksCompleted": 0] as [String : Any] as NSDictionary
        
        let values: NSDictionary = [Constants.API.email: user.email,
                                                  Constants.API.firstName: user.firstName ?? " ",
                                                  Constants.API.lastName: user.lastName ?? " ",
                                                  Constants.API.profilePicture: user.profilePicture ?? " ",
                                                  Constants.API.experiencePoints: user.experiencePoints ,
                                                  Constants.API.level: user.level,
                                                  Constants.API.joinDate: user.joinDate,
                                                  Constants.API.username: user.username,
                                                  Constants.API.tasksCompleted: user.numberOfTasksCompleted]
        
        userRef.updateChildValues(values as! [AnyHashable : Any]) { err, ref in
            if err != nil {
                
                print(err ?? "unable to get specific error")
                return
            }
        }
    }
            //
            //    let ref = FIRDatabase.database().reference()
            //    let newUser = self.createUser(username: username, email: email)
            //    let usersReference = ref.child("Users").child(uid)
            //    let usernamesReference = ref.child("Usernames")
            //    let usernameValues = [newUser.username:newUser.email] as [String : Any] as NSDictionary
            //
            //    usernamesReference.updateChildValues(usernameValues as! [AnyHashable : Any]) { err, ref in
            //    if err != nil {
            //    loadingView.hideActivityIndicator(viewController: self)
            //    print(err ?? "unable to get specific error i")
            //    return
            //    }
            //    print("sucessfully saved username email reference")
            //    }
            //
            //    let values = ["Username": newUser.username, "Email": newUser.email, "FirstName": newUser.firstName!, "LastName": newUser.lastName!, "ProfilePicture": newUser.profilePicture!, "ExperiencePoints": newUser.experiencePoints, "Level": newUser.level, "JoinDate":newUser.joinDate, "TasksCompleted": 0] as [String : Any] as NSDictionary
            //
            //    usersReference.updateChildValues(values as! [AnyHashable : Any]) { err, ref in
            //    if err != nil {
            //    loadingView.hideActivityIndicator(viewController: self)
            //    print(err ?? "unable to get specific error")
            //    return
            //    }
            //    print("Saved user successfully into Firebase db")
            //    self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
            //    self.store.currentUser = newUser
            //    self.setupTabBar()
            //    }
}
