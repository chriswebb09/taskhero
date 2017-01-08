//
//  HomeViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum HomeCellType {
    case task, header
}

class HomeViewControllerDataSource {
    let store = DataStore.sharedInstance
    fileprivate var taskViewModel: TaskCellViewModel!
    
    // Number of rows in HomeViewController, if no tasks it returns 1 for ProfileHeaderCell
    
    var rows: Int {
        get {
            if (store.currentUser.tasks?.count)! < 1 {
                return 1
            } else {
                return (store.currentUser.tasks!.count) + 1
            }
        }
    }
    
    var rowHeight = UITableViewAutomaticDimension
    
    var indexPath: IndexPath!
    var autoHeight: UIViewAutoresizing?
}

extension HomeViewControllerDataSource {
    
    func configure(indexPath:IndexPath, cellType:HomeCellType, tableView:UITableView) -> UITableViewCell {
        if cellType == .header {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath) as! ProfileHeaderCell
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath) as! TaskCell
            taskViewModel = TaskCellViewModel((self.store.currentUser.tasks?[indexPath.row - 1])!)
            taskCell.configureCell(taskVM: taskViewModel)
            return taskCell
        }
    }
    
    func setupView(tableView:UITableView, view:UIView) {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.setupHelper()
        tableView.estimatedRowHeight = view.frame.height / 4
    }
    
    func configureHeader(headerCell:ProfileHeaderCell, viewController:HomeViewController) {
        headerCell.delegate = viewController
        headerCell.emailLabel.isHidden = true
        headerCell.configureCell(autoHeight: UIViewAutoresizing.flexibleHeight)
        if viewController.profilePic != nil {
            headerCell.profilePicture.image = self.store.profilePicture
        }
    }
    
//    func checkForPicURL(completion: @escaping(UIImage) -> Void) {
//        if (self.store.currentUser.profilePicture?.characters.count)! > 0 && self.store.currentUser.profilePicture != "None" {
//            store.firebaseAPI.downloadImage(imageName: self.store.currentUser.profilePicture!) { image in
//                completion(image)
//            }
//        }
//    }
    
    func setupTaskCell(taskCell:TaskCell, viewController:HomeViewController) {
        taskCell.delegate = viewController
        taskCell.taskDescriptionBox.delegate = viewController
        taskCell.toggled = viewController.tapped
        let tap = UIGestureRecognizer(target: self, action: #selector(viewController.toggleForEditState(sender:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
    }
    
    func selectImage(picker:UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    func deleteTask(indexPath: IndexPath) {
        let removeTaskID: String = self.store.currentUser.tasks![indexPath.row - 1].taskID
        self.store.tasks = self.store.currentUser.tasks!
        self.store.tasks.remove(at: indexPath.row - 1)
        self.store.updateUserScore()
        self.store.firebaseAPI.registerUser(user: self.store.currentUser)
        self.store.firebaseAPI.removeTask(ref: removeTaskID, taskID: removeTaskID)
    }
}


