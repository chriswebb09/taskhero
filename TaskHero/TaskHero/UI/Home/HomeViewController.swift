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
    
    /*
     - HomeViewController is the first tab in the Bar. It is a tableView that consists of a ProfileHeaderCell at indexPath.row 0
     - All other cells are of type TaskCell
     - behavior is is currently being abstracted out HomeViewController to HomeViewControllerDataSource
     - Not final setup - still a work in progress
     */
    
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)  /* BackgroundQueue 
                                                                                                        for background network */
    var dataSource: HomeViewControllerDataSource!     /* Abstraction of tableView configuration methods */
    let photoPopover = PhotoPickerPopover()      /* Custom Alert/Popover view used for picking profile photo on profilePicture tap */
    let picker = UIImagePickerController()      /* Used to pick profile picture in photoPopover */
    var tapped: Bool = false       /* Used to toggling TaskCell interface / Implemented in HomeViewControllerDataSource */
    let helpers = Helpers()     /* Helper methods mainly for configuring */
    var index:IndexPath!   /* IndexPath property still figuring out if I need it */
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
        dataSource.setupView(tableView:tableView, view:view)
        addNavItemsToController()
    }
    
    /* Before view appears fetches user data & loads tasks into datastore befroe reloading tableview
     If there are tasks in datastore removes tasks before load
     */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        helpers.getData(tableView: tableView)
    }
    
    /* Removes reference to database - necessary to prevent duplicate task cells from loading when
     view will appears is called again.
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        helpers.removeRefHandle()
    }
}

// Extension for methods that define view controller setup i.e. numberOfRowsInSection, cellForRowAt

extension HomeViewController: ProfileHeaderCellDelegate, UITextViewDelegate, TaskCellDelegate {
    
    // =======================================
    // MARK: UITableViewController Methods
    // =======================================
    
    // Returns number of rows based on count taskcount
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.rows
    }
    
    // Gets rowheight from datasource and returns it - rowheight is UITableViewAutomaticDimension
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.rowHeight
    }
    
    /* If first row returns profile header cell else returns task cell */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource.tableIndexPath = indexPath
        if indexPath.row == 0 {
            let headerCell = dataSource.configure(indexPath: indexPath, cellType:.header, tableView: tableView) as! ProfileHeaderCell
            dataSource.setupHeaderCell(headerCell: headerCell, viewController:self)
            index = indexPath
            return headerCell
        } else {
            let taskCell = dataSource.configure(indexPath: indexPath, cellType:.task, tableView: tableView) as! TaskCell
            dataSource.setupTaskCell(taskCell: taskCell, viewController: self)
            taskCell.taskDescriptionBox.delegate = self
            taskCell.saveButton.tag = indexPath.row
            return taskCell
        }
    }
    
    /* Logic for deleting tasks from database when user deletes tableview cell */
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        guard indexPath.row != 0 else { return }
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            backgroundQueue.async {
//                self.dataSource.deleteTask(indexPath:indexPath, tableView: self.tableView)
//            }
//            DispatchQueue.main.async {
//                self.dataSource.tableIndexPath.row = indexPath.row - 1
//                tableView.reloadData()
//            }
//            tableView.endUpdates()
//        }
//    }
}
