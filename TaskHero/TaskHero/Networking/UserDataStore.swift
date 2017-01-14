
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
    let defaults = UserDefaults.standard
    
    public let firebaseAPI = APIClient()
    public var currentUser: User!
    public var currentUserString: String!
    public var tasks = [Task]()
    
    var profilePicture: UIImage!
    var validUsernames = [String]()
}

extension UserDataStore {
    
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
    
    func hasLoggedIn() {
        let hasLoggedIn = defaults.bool(forKey: "hasLoggedIn")
        let user = defaults.data(forKey: "currentUser")
        if hasLoggedIn {
            print("LOGGED IN")
            dump(user)
        }
    }
    
    func setLoggedInKey(userState:Bool) {
        defaults.set(userState, forKey: "hasLoggedIn")
    }
    
    func setUserData(user: User) {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: user), forKey: "currentUser")
        defaults.synchronize()
    }
    
    
    func logout() {
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.removeObject(forKey: "currentUser")
        defaults.removeObject(forKey: "UID")
        defaults.synchronize()
    }
}
