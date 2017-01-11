//
//  Levels.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/3/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


struct Levels {
    
    func getLevelFor(_ user:User) -> String {
        if user.experiencePoints < 20 {
            return "Task Goat"
        } else {
            return "Task Wizard"
        }
    }
}
