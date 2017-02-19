//
//  HomeViewModel.swift
//  TaskHero
//

import UIKit

struct HomeViewModel {
    
    var store = UserDataStore.sharedInstance
    
    fileprivate let concurrentQueue =
        DispatchQueue(
            label: "com.taskHero.concurrentQueue",
            attributes: .concurrent)
    
    var user: User {
        return self.store.currentUser
    }
    
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
    
    func fetchTasks(tableView: UITableView) {
        self.store.firebaseAPI.fetchUserData() { user in
            self.store.firebaseAPI.fetchTaskList() { taskList in
                self.concurrentQueue.async {
                    self.store.currentUser = user
                    self.store.tasks = taskList
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
              
            }
        }
    }
}
