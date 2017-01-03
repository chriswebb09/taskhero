//
//  Levels.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/3/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


struct Levels {
    
    var user: User?
    
    var level: String {
        if (user?.experiencePoints)! < 20 {
            return "Task Goat"
        } else {
            return "Task Wizard"
        }
        
    }
    
   // let store = DataStore.sharedInstance
    
    //var user: User
    
//    var taskGoat: String {
//        if user.experiencePoints < 20 {
//            user.level = "Task Goat"
//            
//        }
//        return "Task Goat"
//    }
//    
//    var taskWizard: String {
//        if user.experiencePoints > 20 {
//            user.level = "Task Wizard"
//        }
//        return "Task Wizard"
//    }
}
