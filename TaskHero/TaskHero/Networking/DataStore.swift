
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
    
    func setupStore() {
        tasks.removeAll()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
    
    // Temporary functionality moved into DataStore during project reorganiztion. Will be removed at completion.
    
    // ===========================================================
    // Update currentUser score when user completes task
    // ===========================================================
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
    
}
