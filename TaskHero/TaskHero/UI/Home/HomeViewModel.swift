//
//  HomeViewModel.swift
//  TaskHero
//

import UIKit

enum HomeCellType {
    case task, header
    var identifier: String {
        switch self {
        case .header:
            return ProfileHeaderCell.cellIdentifier
        case .task:
            return TaskCell.cellIdentifier
        }
    }
}

struct HomeViewModel {
    
    var store = UserDataStore.sharedInstance
    fileprivate let concurrentQueue = DispatchQueue(label: "com.taskHero.concurrentQueue", attributes: .concurrent)
    var profilePic: UIImage?
    var user: User? {
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
    
    func removeRefHandle() {
        if store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
    
    func getViewModelForTask(taskIndex: Int) -> TaskCellViewModel {
        return TaskCellViewModel(taskList[taskIndex - 1])
    }
    
    func objectAtIndexPath(indexPath: IndexPath) -> Task? {
        return taskList.indices.contains(indexPath.row) ? taskList[indexPath.row] : nil
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return taskList.count
    }
}
