//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    // =================================
    // MARK: Internal Properties
    // =================================
    
    var dataSource: HomeViewControllerDataSource!
    let store = DataStore.sharedInstance
    let photoPopover = PhotoPickerPopover()
    let picker = UIImagePickerController()
    var profilePic: UIImage? = nil
    var tapped: Bool = false
    var buttonTapped: Bool = false
    let helpers = Helpers()
    var index:IndexPath!
}

extension HomeViewController: UINavigationControllerDelegate {
    
    // ==============================
    // MARK: - Initialization
    // ==============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        edgesForExtendedLayout = []
        dataSource = HomeViewControllerDataSource()
        dataSource.checkForPicURL { [weak self] image in
            self?.profilePic = image
        }
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        dataSource.setupView(tableView:tableView, view:view)
        setupNavItems()
    }
    
    // Before view appears fetches user data & loads tasks into datastore befroe reloading tableview
    // If there are tasks in datastore removes tasks before load
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        helpers.getData(tableView: tableView)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        helpers.removeRefHandle()
    }
}

extension HomeViewController: ProfileHeaderCellDelegate, UITextViewDelegate, TaskCellDelegate {
    
    // =======================================
    // MARK: UITableViewController Methods
    // =======================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    // If first row returns profile header cell else returns task cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource.indexPath = indexPath
        if indexPath.row == 0 {
            let headerCell = dataSource.configure(indexPath: indexPath, cellType: HomeCellType.header) as! ProfileHeaderCell
            dataSource.configureHeader(headerCell: headerCell, viewController:self)
            index = indexPath
            return headerCell
        } else {
            let taskCell = dataSource.configure(indexPath: indexPath, cellType: HomeCellType.task) as! TaskCell
            dataSource.setupTaskCell(taskCell: taskCell, viewController: self)
            taskCell.saveButton.tag = indexPath.row
            return taskCell
        }
    }
    
    // Logic for deleting tasks from database when user deletes tableview cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        if editingStyle == .delete {
            tableView.beginUpdates()
            DispatchQueue.main.async {
                let removeTaskID: String = self.store.currentUser.tasks![indexPath.row - 1].taskID
                self.store.tasks = self.store.currentUser.tasks!
                self.store.tasks.remove(at: indexPath.row - 1)
                self.store.updateUserScore()
                self.store.firebaseAPI.registerUser(user: self.store.currentUser)
                self.store.firebaseAPI.removeTask(ref: removeTaskID, taskID: removeTaskID)
                print(self.dataSource)
                tableView.reloadData()
                tableView.endUpdates()
            }
            
        }
    }
}
