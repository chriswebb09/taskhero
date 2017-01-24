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

protocol CellMake {
    func configure(indexPath: IndexPath, cellType: HomeCellType, tableView:UITableView) -> UITableViewCell
}

final class HomeViewControllerDataSource {
    /* Temporary abstraction of HomeViewController behavior. Not finalized will be organized into datasource and flowcontroller */
    
    let store = UserDataStore.sharedInstance
    fileprivate var taskViewModel: TaskCellViewModel!
    var delete: Bool = false
    
    /* Number of rows in HomeViewController, if no tasks it returns 1 for ProfileHeaderCell */
    
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
    var tableIndexPath: IndexPath!
    var autoHeight: UIViewAutoresizing?
}

/* Extension containing method for configuring cells in ViewController. */
/* If passed in indexPath.row is 0, the cell returned is ProfileHeaderCell */

extension HomeViewControllerDataSource: CellMake {
    
    func configure(indexPath:IndexPath, cellType:HomeCellType, tableView:UITableView) -> UITableViewCell {
        if cellType == .header {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath) as! ProfileHeaderCell
            return headerCell
        } else {
            var taskViewModel: TaskCellViewModel!
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath) as! TaskCell
            self.store.currentUser.tasks = self.store.tasks
            taskViewModel = TaskCellViewModel((self.store.currentUser.tasks?[indexPath.row - 1])!)
            taskCell.configureCell(taskVM: taskViewModel)
            return taskCell
        }
    }
    
    // Methods for configure UIElements + registers cell types for tableView
    /* Sets estimatedRowHeight and registers cell types */
    
    func setupView(tableView:UITableView, view:UIView) {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.setupTableView()
        tableView.estimatedRowHeight = view.frame.height / 4
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
    }
    
    /* Setup HeaderCell - configuration and adding delegates to HomeViewController  */
    
    func setupHeaderCell(headerCell:ProfileHeaderCell, viewController:HomeViewController) {
        headerCell.delegate = viewController
        headerCell.emailLabel.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.profilePictureTapped))
        headerCell.configureCell(autoHeight: UIViewAutoresizing.flexibleHeight, gesture:tap)
    }
    
    /* Setup TaskCell configuration and adding delegates to HomeViewController */
    
    func setupTaskCell(taskCell:TaskCell, viewController:HomeViewController) {
        taskCell.delegate = viewController
        let tap = UIGestureRecognizer(target: viewController, action: #selector(viewController.toggleForEditState(_:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
    }
    
    // Method choosing profilePicture for Header cell
    
    func selectImage(picker:UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    /* Deletes task at indexPath.row - 1 - subtraction because TaskCells are below the profileHeader cell */
    
    func deleteTask(indexPath: IndexPath, tableView:UITableView) {
        DispatchQueue.global(qos: .default).async {
            let removeTaskID: String = self.store.currentUser.tasks![indexPath.row - 1].taskID
            if let tasks = self.store.currentUser.tasks { self.store.tasks = tasks }
            print(indexPath.row - 1)
            self.store.tasks.remove(at: indexPath.row - 1)
            self.store.updateUserScore()
            self.store.firebaseAPI.registerUser(user: self.store.currentUser)
            self.store.firebaseAPI.removeTask(ref: removeTaskID, taskID: removeTaskID)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
        print(self.store.tasks)
    }
    
    // Selector method for taskCompletedView and SaveButton in TaskCell - cycles between them depending on the state to either edit or save
    
    func tapEdit(viewController: HomeViewController, tableView: UITableView, atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        if tapCell.toggled == false {
            var newTask = self.store.tasks[atIndex.row - 1]
            newTask.taskDescription = tapCell.taskDescriptionLabel.text
            self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            tapCell.taskDescriptionLabel.text = newTask.taskDescription
        }
        let tap = UIGestureRecognizer(target: viewController, action: #selector(viewController.toggleForEditState(_:)))
        tapCell.taskCompletedView.addGestureRecognizer(tap)
        tapCell.taskCompletedView.isUserInteractionEnabled = true
    }
}


