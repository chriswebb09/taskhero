//
//  HomeHelpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/8/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


enum HomeCellType {
    case task, header
}

protocol Toggable {
    func toggleState(state:Bool) -> Bool
}

extension Toggable {
    func toggleState(state:Bool) -> Bool {
        return !state
    }
}

//extension HomeViewController {
//    
//    func updateTasks() {
//        DispatchQueue.global(qos: .background).async {
//            self.updateData()
//        }
//    }
//    
//    func updateData() {
//        self.fetchUser() { user in
//            DispatchQueue.main.async {
//                self.store.currentUser = user
//                self.tasks = self.homeViewModel.tasks
//            }
//        }
//    }
//    
//    func removeTasks() {
//        if let userTasks = self.store.currentUser.tasks {
//            if (self.store.tasks.count > 0) || (userTasks.count > 0) {
//                store.tasks.removeAll()
//                store.currentUser.tasks?.removeAll()
//            }
//        }
//    }
//    
//    func fetchBaseUser() {
//        store.firebaseAPI.fetchUserData { user in
//            self.homeViewModel.user = user
//            self.store.currentUser = user
//        }
//    }
//    
//    func fetchUser(completion: @escaping UserCompletion) {
//        removeTasks()
//        fetchBaseUser()
//        if let tasklist = self.store.currentUser.tasks {
//            store.firebaseAPI.fetchTasks(taskList: tasklist) { tasks in
//                self.store.currentUser.tasks = tasks
//                self.store.tasks = tasks
//                completion(self.store.currentUser)
//            }
//        }
//        
//    }
