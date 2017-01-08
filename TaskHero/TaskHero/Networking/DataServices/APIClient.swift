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
    
    // =====================================================
    // Firebase properties
    // =====================================================
    
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
    // =====================================================
    // App data properties
    // =====================================================
    
    var validUsernames = [String]()
    var validUserData = [String]()
    var userData = Dictionary<String, AnyObject>()
    var usernameEmailDict = Dictionary<String, AnyObject>()
    var tasksDict = Dictionary<String, AnyObject>()
    
    
    init() {
        dbRef = FIRDatabase.database().reference()
        usernameRef = dbRef.child("Usernames")
    }
    
    // =====================================================
    // Initial firebase database reference properties
    // =====================================================
    
    func setupRefs() {
        //let userID = FIRAuth.auth()?.currentUser?.uid
        userRef = dbRef.child("Users").child(userID!)
        tasksRef = dbRef.child("Users").child(userID!).child("Tasks")
    }
    
    // =====================================================
    // Fetch all valid usernames in database
    // =====================================================
    
    func fetchValidUsernames() {
        validUsernames.removeAll()
        usernameRef.observe(.childAdded, with: { snapshot in
            self.validUsernames.append(snapshot.key)
            self.usernameEmailDict[snapshot.key] = snapshot.value as AnyObject?
        })
    }
    
    // ================================================================================
    // Fetch user profile data store in realtime database return data in completion
    // ================================================================================
    
    func fetchUser(completion:@escaping UserCompletion) {
        let database = FIRDatabase.database()
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(uid)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        database.reference().child("Users").child(uid).observe(.value, with: { snapshot in
            let tasks = [Task]()
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            let user = User()
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
            user.tasks = tasks
            completion(user)
        })
    }
    
    
    
    // =========================================================================
    // Grab tasks from user profile in realtime user database
    // =========================================================================
    
    func fetchTasks(taskList: [Task], completion:@escaping ([Task]) -> Void) {
        // tasksRef.keepSynced(true)
        var taskList = taskList
        refHandle = tasksRef.observe(.childAdded, with: { snapshot in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
            var newTask = Task()
            newTask.taskID = snapshot.key
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
            taskList.append(newTask)
            completion(taskList)
        })
    }
    
    
    
    
    func fetchUserData(completion: @escaping UserCompletion) {
        let userLastOnlineRef = FIRDatabase.database().reference(withPath: "Users/\(userID!)/LastOnline")
        userLastOnlineRef.onDisconnectSetValue(FIRServerValue.timestamp())
        userRef.child(userID!).observe(.childAdded, with: { snapshot in
            let user = User()
            self.userData[snapshot.key] = snapshot.value as AnyObject?
            
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
            
            completion(user)
        })
    }
    
    // =============================================================================================================
    // Adds new task to database - called from all viewcontrollers except popovers and addtaskviewcontroller
    // =============================================================================================================
    
    func addTasks(task:Task) {
        tasksRef = dbRef.child("Users").child(userID!).child("Tasks")
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskName)").setValue(task.taskName)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDescription)").setValue(task.taskDescription)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCreated)").setValue(task.taskCreated)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskDue)").setValue(task.taskDue)
        tasksRef.child("\(task.taskID)/\(Constants.API.Task.taskCompleted)").setValue(task.taskCompleted)
        tasksRef.keepSynced(true)
    }
    
    // ========================================================================
    // Removes task from database - called on swift left in tableview
    // ========================================================================
    
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
    
    // ==============================================
    // Updates user profile data in database
    // ==============================================
    
    func updateUserProfile(userID: String, user:User, tasks:[Task]) {
        userRef = dbRef.child("Users")
        let userData: NSDictionary = [Constants.API.User.email: user.email,
                                      Constants.API.User.firstName: user.firstName ?? " ",
                                      Constants.API.User.lastName: user.lastName ?? " ",
                                      Constants.API.User.profilePicture: user.profilePicture ?? " ",
                                      Constants.API.User.experiencePoints: user.experiencePoints ,
                                      Constants.API.User.level: user.level,
                                      Constants.API.User.joinDate: user.joinDate,
                                      Constants.API.User.username: user.username,
                                      Constants.API.User.tasksCompleted: user.numberOfTasksCompleted]
        userRef.updateChildValues(["/\(userID)": userData])
        userRef.keepSynced(true)
        if tasks.count != 0 {
            for task in user.tasks! {
                addTasks(task: task)
            }
        }
        
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
    
    func downloadImage(imageName:String, completion: @escaping (UIImage) -> Void) {
        let name = "146CC8EC-7042-4406-9BC5-8ED7419C919B.png"
        let imageRef = FIRStorage.storage().reference().child("profile_images").child("\(name)")
        print(imageRef)
        var image: UIImage!
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // let prefix = "file:"
        let localURL = NSURL(string:"file://\(paths[0])/\(imageName)")
        let filePath = localURL as? URL
        print(filePath)
        let downloadTask = imageRef.write(toFile: filePath!) { url, error in
            if error != nil {
                print(error?.localizedDescription)
                print("Error occured")
            } else {
                print(localURL?.absoluteString)
                image = UIImage(contentsOfFile: (localURL?.absoluteString)!)
                //if let imageDownloaeed =
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
        }
        downloadTask.resume()
        //        let downloadTask = imageRef.write(filePath) { url, error in
        //            if error != nil {
        //                print(error?.localizedDescription)
        //                print("Error occured")
        //            } else {
        //                image = UIImage(contentsOfFile: (localURL?.absoluteString)!)
        //                DispatchQueue.main.async {
        //                    completion(image)
        //                }
        //
        //            }
        //        }
        //        downloadTask.resume()
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
        
        let values: NSDictionary = [Constants.API.User.email: user.email,
                                    Constants.API.User.firstName: user.firstName ?? " ",
                                    Constants.API.User.lastName: user.lastName ?? " ",
                                    Constants.API.User.profilePicture: user.profilePicture ?? " ",
                                    Constants.API.User.experiencePoints: user.experiencePoints ,
                                    Constants.API.User.level: user.level,
                                    Constants.API.User.joinDate: user.joinDate,
                                    Constants.API.User.username: user.username,
                                    Constants.API.User.tasksCompleted: user.numberOfTasksCompleted]
        
        userRef.updateChildValues(values as! [AnyHashable : Any]) { err, ref in
            if err != nil {
                print(err ?? "unable to get specific error")
                return
            }
        }
    }
}
