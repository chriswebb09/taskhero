//
//  HomeViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class HomeViewControllerDataSource {
    let store = DataStore.sharedInstance
    fileprivate var taskViewModel: TaskCellViewModel!
    var rows: Int {
        get {
            if (store.currentUser.tasks?.count)! < 1 {
                return 1
            } else {
                return (store.currentUser.tasks!.count) + 1
            }
        }
    }
    
    var indexPath: IndexPath!
    var autoHeight: UIViewAutoresizing?
}

extension HomeViewControllerDataSource {
    
    func configure(indexPath:IndexPath, cellType:HomeCellType) -> UITableViewCell {
        if cellType == .header {
            print("header")
            let headerCell = ProfileHeaderCell()
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
            let taskCell = TaskCell()
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
}

enum HomeCellType {
    case task, header
}
