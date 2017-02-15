//
//  HomeViewModel.swift
//  TaskHero
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
        let rows: Int = self.store.tasks.count <= 0 ? 1 : self.store.tasks.count + 1
        return rows
    }

    var taskList: [Task] {
       return self.store.tasks
    }
    var rowHeight = UITableViewAutomaticDimension
}
