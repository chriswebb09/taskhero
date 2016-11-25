//
//  AppManager.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class AppManager {
    static let sharedInstance = AppManager()
    let defaults = UserDefaults.standard
    
    func userIsLoggedIn(loggedIn: Bool) {
        defaults.set(loggedIn, forKey: "loggedIn")
    }
}
