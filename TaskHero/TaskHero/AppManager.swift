//
//  AppManager.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Firebase

class AppManager {
    
    static let sharedInstance = AppManager()
    let defaults = UserDefaults.standard
    
    func userIsLoggedIn(loggedIn: Bool, uid: String?) {
        defaults.set(loggedIn, forKey: "loggedIn")
        defaults.set(uid, forKey: "UID")
        defaults.synchronize()
    }
    
    func setUserData(user: User) {
        //let data = user as! Any
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: user), forKey: "currentUser")
        defaults.synchronize()
    }
}
