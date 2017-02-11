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
                getUserName(textFieldText: username)
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
                getUserName(textFieldText: password)
            }
        }
    }
    
    func getUserName(textFieldText: String) {
        print("getting user credentials\(textFieldText)")
    }
    
    var isValid: Bool {
        if username.characters.count > 4 && password.characters.count > 8 {
            return true
        } else {
            return false
        }
    }
    
    var enableColor: UIColor {
        if isValid == true {
            return .blue
        } else {
            return .lightGray
        }
    }
}

