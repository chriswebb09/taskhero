//
//  HomeViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class HomeViewModel {
    var store = UserDataStore.sharedInstance
    
    var usernameText: String {
        return store.currentUser.username
    }
    
    var levelText: String {
        return store.currentUser.level
    }
    
    var numberOfRows: Int {
        guard let tasks = store.currentUser.tasks else { return 1 }
        return tasks.count + 1
    }
    
    var rowHeight = UITableViewAutomaticDimension
}
