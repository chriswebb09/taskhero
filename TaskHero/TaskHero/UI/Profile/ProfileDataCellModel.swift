//
//  ProfileDataCellModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/21/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileDataCellModel {
    var level: String { get }
    var experience: Int { get }
    var tasksCompleted: Int { get }
}

struct ProfileDataCellViewModel {
    // MARK: - Internal Variables
    
    let store = UserDataStore.sharedInstance
    
    internal var tasksCompleted: Int
    internal var experience: Int
    internal var level: String

    // MARK: - Initialization
    
    init() {
        self.level = (self.store.currentUser.level)
        self.experience = (self.store.currentUser.experiencePoints)
        self.tasksCompleted = (self.store.currentUser?.numberOfTasksCompleted)!
    }
}
