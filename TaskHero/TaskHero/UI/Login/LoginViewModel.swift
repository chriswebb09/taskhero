//
//  LoginViewModel.swift
//  TaskHero
//

import UIKit

struct LoginViewModel {
    
    var username: String {
        willSet {
            print("About to set username to:  \(newValue)")
        }
        
        didSet {
            if username != oldValue {
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
