
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
    
    let firebaseAPI = APIClient()
    var currentUser: User!
    ///var profilePicture: UIImage!
    var currentUserString: String!
    var validUsernames = [String]()
    var tasks = [Task]()
    
    // ===========================================================
    // Update currentUser score when user completes task
    // ===========================================================
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
    
    // ==============================================
    // Update currentUser profile in database
    // ==============================================
    
    func updateUserProfile(userID: String, user:User) {
        firebaseAPI.updateUserProfile(userID: userID, user: user, tasks:tasks)
        self.tasks.forEach { task in
            firebaseAPI.updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
    // =============================================
    // Setup datastore for initial operation
    // =============================================
    
    
    func fetchUser(completion: @escaping(User) -> Void) {
        self.tasks.removeAll()
        self.currentUser.tasks?.removeAll()
        firebaseAPI.fetchUser { user in
            self.currentUser = user
        }
        
        firebaseAPI.fetchTasks(taskList: currentUser.tasks!) { tasks in
            self.currentUser.tasks = tasks
            self.tasks = tasks
            dump(self.currentUser)
            completion(self.currentUser)
        }
    }
    
    func setupStore() {
        tasks.removeAll()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
}
