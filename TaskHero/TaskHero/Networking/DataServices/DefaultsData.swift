//
//  DefaultsData.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class DefaultsData {
    let defaults = UserDefaults.standard
    
    func hasLogged() {
        let hasLoggedIn = defaults.bool(forKey: "hasLoggedIn")
        if hasLoggedIn {
            print("LOGGED IN")
        }
    }
    
    
    func setLoggedInKey(userState:Bool) {
        defaults.set(userState, forKey: "hasLoggedIn")
    }
    
}
