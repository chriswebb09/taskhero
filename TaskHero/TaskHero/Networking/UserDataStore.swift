
//
//  DataStore.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import Firebase

final class UserDataStore {
    
    private static let _shared = UserDataStore()
    private init() { }
    
    public static var sharedInstance: UserDataStore {
        return _shared
    }
    
    
    public let firebaseAPI = APIClient()
    public var currentUser: User!
    public var currentUserString: String!
    public var tasks = [Task]()
    
    var profilePicture: UIImage!
    var validUsernames = [String]()
    
    // basic setups for dataStore, removes all tasks from store tasks and currentUser tasks
    
    func setupStore() {
        tasks.removeAll()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
    
    // Temporary functionality moved into DataStore during project reorganiztion. Will be removed at completion.
    // Update currentUser score when user completes task
    // adds to one point to user experience points and addd one task to numberOfTasksCompleted
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
    

}
