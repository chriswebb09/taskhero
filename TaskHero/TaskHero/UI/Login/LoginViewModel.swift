//
//  LoginViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


struct LoginViewModel {
    var userName: String!
    var password: String!
    
    var isValid: Bool {
        if userName.characters.count > 4 && password.characters.count > 5 {
            return true
        } else {
            return false
        }
    }
}

