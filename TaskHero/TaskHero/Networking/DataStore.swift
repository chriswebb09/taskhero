
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
    var profilePicture: UIImage!
    var currentUserString: String!
    var validUsernames = [String]()
    
    var tasks = [Task]()
    
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
    
    
    
    func updateUserProfile(userID: String, user:User) {
        firebaseAPI.updateUserProfile(userID: userID, user: user)
        self.tasks.forEach { task in
            firebaseAPI.updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
    
    func setupStore() {
        tasks.removeAll()
        firebaseAPI.fetchUserData()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
}
