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
