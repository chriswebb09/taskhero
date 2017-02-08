
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
    
    func setupStore() {
        tasks.removeAll()
        if currentUser.tasks != nil { currentUser.tasks?.removeAll() }
    }
    
    func updateUserScore() {
        currentUser.experiencePoints += 1
        currentUser.numberOfTasksCompleted += 1
    }
}
