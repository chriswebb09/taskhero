//
//  ProfileDataCellModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/21/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileDataCellVM {
    var user: User? { get set }
    var level: String { get }
    var experience: Int { get }
    var tasksCompleted: Int { get }
}

class ProfileDataCellViewModel: ProfileDataCellVM {
    
    let store = DataStore.sharedInstance
    
    internal var tasksCompleted: Int
    internal var experience: Int
    internal var level: String
    internal var user: User?
    
    init() {
        self.user = self.store.currentUser
        self.level = (user?.level)!
        self.experience = (user?.experiencePoints)!
        self.tasksCompleted = (user?.numberOfTasksCompleted)!
    }
    
}
