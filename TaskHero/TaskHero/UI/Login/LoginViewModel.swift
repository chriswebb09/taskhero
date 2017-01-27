//
//  LoginViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct LoginViewModel {
    
    var username: String {
        willSet {
            print("About to set username to:  \(newValue)")
        }
        
        didSet {
            if username != oldValue {
                print(isValid)
                getUserName()
            }
        }
    }
    
    var password: String {
        willSet {
            print("About to set password to:  \(newValue)")
        }
        
        didSet {
            if password != oldValue {
                print(isValid)
                getUserName()
            }
        }

    }
    
    
    
    
    func getUserName() {
        print("getting user credentials")
    }
    
    
    var isValid: Bool {
        if username.characters.count > 4 && password.characters.count > 5 {
            return true
        } else {
            return false
        }
    }
    
    var enableColor: UIColor {
        if isValid == true {
            return UIColor.blue
        } else {
            return UIColor.lightGray
        }
    }
}

