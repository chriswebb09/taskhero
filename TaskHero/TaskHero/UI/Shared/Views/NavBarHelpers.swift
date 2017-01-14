//
//  NavBarHelpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/11/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NavBarHelpers {
    
    func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDataStore.sharedInstance.logout()
        appDelegate.window?.rootViewController = loginVC
    }
}
