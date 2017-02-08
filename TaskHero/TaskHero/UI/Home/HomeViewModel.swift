  //
//  HomeViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct HomeViewModel {
    
    var store = UserDataStore.sharedInstance
    
    var user: User!
    
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
    
    var tasks: [Task] {
        guard let tasks = store.currentUser.tasks else { return [] }
        return tasks
    }
    
    var rowHeight = UITableViewAutomaticDimension

}
