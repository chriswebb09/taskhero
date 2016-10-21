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
    
    var currentUser: User!
    var currentUserString: String!
    var tasks = [Task]()
    
    static let sharedInstance = DataStore()
    
    
    func fetchUser(completion:@escaping (User)-> ()) {
        FIRDatabase.database().reference().child("Users").child(self.currentUserString).observeSingleEvent(of: .value, with: { (snapshot) in
            //guard let snapshotValue = snapshot.value as? [String: AnyObject] else { return }
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
}
