//
//  APIClient.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import Firebase

typealias TaskCompletion = ([Task]) -> Void
typealias UserCompletion = (User) -> Void

final class APIClient {

    // Firebase properties
    
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
    let userID = FIRAuth.auth()?.currentUser?.uid
    let database = FIRDatabase.database()
    let syncedUser = FIRDatabase.database().reference(withPath: "Users")
    
    init() {
        syncedUser.keepSynced(true)
        dbRef = FIRDatabase.database().reference()
        usernameRef = dbRef.child("Usernames")
        setupRefs()
    }
    
    // MARK:- Initial firebase database reference properties
    
    func setupRefs() {
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        userRef = dbRef.child("Users").child(userID)
        tasksRef = dbRef.child("Users").child(userID).child("Tasks")
    }
    
    /* Remove task from database */
    
    func removeTask(ref:String, taskID: String) {
        tasksRef.child(ref).removeValue()
    }
    
    /* Fetch all valid usernames in database */
    
    public func updateUsernameList(user: User) {
        ref = FIRDatabase.database().reference()
        let usernameRefs = ref.child("Usernames")
        let usernameValues = [user.username:user.email] as [String : Any] as NSDictionary
        usernameRefs.updateChildValues(usernameValues as! [AnyHashable : Any]) { err, ref in
            if err != nil {
                print(err ?? "unable to get specific error i")
                return
            }
        }
    }
    
    /* Adds new task to database - called from all viewcontrollers except popovers and addtaskviewcontroller */
    
    func addTasks(task:Task) {
        tasksRef = dbRef.child("Users").child(userID!).child("Tasks")
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskName)").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDescription)").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCreated)").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDue)").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCompleted)").setValue(task.taskCompleted)
        tasksRef.keepSynced(true)
    }
    
    /* Updates values of task when task is editted */
    
    func fetchTasks(taskList: [Task], completion: @escaping TaskCompletion) {
        var taskList = taskList
        refHandle = tasksRef.observe(.childAdded, with: { snapshot in
            let newTask = self.createTaskSnapshot(snapshot: snapshot)
            if let task = newTask {
                taskList.append(task)
            }
            completion(taskList)
        })
    }
    
    
    func fetchTaskList(completion: @escaping TaskCompletion) {
        var taskList = [Task]()
        refHandle = tasksRef.observe(.childAdded, with: { snapshot in
            let newTask = self.createTaskSnapshot(snapshot: snapshot)
            if let task = newTask {
                taskList.append(task)
            }
            completion(taskList)
        })
    }
    
    
    func createTaskSnapshot(snapshot: FIRDataSnapshot) -> Task? {
        var newTask = Task()
        newTask.taskID = snapshot.key
        guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return nil }
        if let fetchName = snapshotValue[Constants.API.Task.taskName] as? String,
            let fetchDescription = snapshotValue[Constants.API.Task.taskDescription] as? String,
            let fetchCreated = snapshotValue[Constants.API.Task.taskCreated] as? String,
            let fetchDue = snapshotValue[Constants.API.Task.taskDue] as? String,
            let fetchCompleted = snapshotValue[Constants.API.Task.taskCompleted] as? Bool {
            newTask.taskName = fetchName
            newTask.taskDescription = fetchDescription
            newTask.taskCreated = fetchCreated
            newTask.taskDue = fetchDue
            newTask.taskCompleted = fetchCompleted
        }
        return Optional(newTask)
    }
    
    func updateTask(ref:String, taskID: String, task:Task) {
        let taskData = createTasksDictionary(task: task)
        tasksRef.updateChildValues(["/\(taskID)": taskData])
    }
    
    /* Updates user profile data in database */
    /* Grab tasks from user profile in realtime user database */
    
    func fetchUserData(completion: @escaping UserCompletion) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(uid)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        database.reference().child("Users").child(uid).observe(.value, with: { snapshot in
            let tasks = [Task]()
            let user = User()
            self.createUserSnapshot(snapshot: snapshot, user: user)
            user.tasks = tasks
            completion(user)
        })
    }
    
    func createUserSnapshot(snapshot: FIRDataSnapshot, user: User) {
        guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
        if let snapshotName = snapshotValue[Constants.API.User.username] as? String,
            let snapshotEmail = snapshotValue[Constants.API.User.email] as? String,
            let snapshotFirstName = snapshotValue[Constants.API.User.firstName] as? String,
            let snapshotLastName = snapshotValue[Constants.API.User.lastName] as? String,
            let snapshotLevel = snapshotValue[Constants.API.User.level] as? String,
            let snapshotJoinDate = snapshotValue[Constants.API.User.joinDate] as? String,
            let snapshotProfilePicture = snapshotValue[Constants.API.User.profilePicture] as? String,
            let snapshotTasksCompleted = snapshotValue[Constants.API.User.tasksCompleted] as? Int,
            let snapshotExperiencePoints = snapshotValue[Constants.API.User.experiencePoints] as? Int {
            user.username = snapshotName
            user.email = snapshotEmail
            user.firstName = snapshotFirstName
            user.lastName = snapshotLastName
            user.level = snapshotLevel
            user.joinDate = snapshotJoinDate
            user.profilePicture = snapshotProfilePicture
            user.numberOfTasksCompleted = snapshotTasksCompleted
            user.experiencePoints = snapshotExperiencePoints
        }
    }
    
    func updateUserProfile(userID: String, user:User, tasks:[Task]) {
        userRef = dbRef.child("Users")
        let userData: NSDictionary = createValuesDictionary(user: user)
        userRef.updateChildValues(["/\(userID)": userData])
        usernameRef.updateChildValues([user.username:user.email])
        userRef.keepSynced(true)
        if tasks.count != 0 {
            guard let userTasks = user.tasks else { return }
            for task in userTasks {
                addTasks(task: task)
            }
        }
    }
    
    func createTasksDictionary(task: Task) -> NSDictionary {
        let taskData: NSDictionary =
            [Constants.API.Task.taskName: task.taskName,
             Constants.API.Task.taskDescription: task.taskDescription ,
             Constants.API.Task.taskCreated: task.taskCreated ,
             Constants.API.Task.taskDue: task.taskDue,
             Constants.API.Task.taskCompleted: task.taskCompleted]
        return taskData
    }
    
    func createValuesDictionary(user: User) -> NSDictionary {
        let values: NSDictionary = [
            Constants.API.User.email: user.email,
            Constants.API.User.firstName: user.firstName ?? " ",
            Constants.API.User.lastName: user.lastName ?? " ",
            Constants.API.User.profilePicture: user.profilePicture ?? " ",
            Constants.API.User.experiencePoints: user.experiencePoints ,
            Constants.API.User.level: user.level,
            Constants.API.User.joinDate: user.joinDate,
            Constants.API.User.username: user.username,
            Constants.API.User.tasksCompleted: user.numberOfTasksCompleted]
        return values
    }
    
    func registerUser(user: User) {
        userRef = dbRef.child("Users").child(user.uid)
        updateUsernameList(user: user)
        let values = createValuesDictionary(user: user)
        userRef.updateChildValues(values as! [AnyHashable : Any]) { err, ref in
            if err != nil {
                print(err ?? "unable to get specific error")
                return
            }
        }
    }
}
