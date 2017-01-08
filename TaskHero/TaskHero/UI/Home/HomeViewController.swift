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
    let photoPopover = PhotoPickerPopover() /* Custom Alert/Popover view used for picking profile photo on profilePicture tap */
    let picker = UIImagePickerController() /* Used to pick profile picture in photoPopover */
    var tapped: Bool = false /* Used to toggling TaskCell interface / Implemented in HomeViewControllerDataSource */
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
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        dataSource.setupView(tableView:tableView, view:view)
        addNavItemsToController()
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


// Extension for methods that define view controller setup i.e. numberOfRowsInSection, cellForRowAt

extension HomeViewController: ProfileHeaderCellDelegate, UITextViewDelegate, TaskCellDelegate {
    
    // =======================================
    // MARK: UITableViewController Methods
    // =======================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.rows // Returns number of rows based on count taskcount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.rowHeight
    }
    
    // If first row returns profile header cell else returns task cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource.indexPath = indexPath
        if indexPath.row == 0 {
            let headerCell = dataSource.configure(indexPath: indexPath, cellType: HomeCellType.header, tableView: tableView) as! ProfileHeaderCell
            dataSource.setupHeaderCell(headerCell: headerCell, viewController:self)
            index = indexPath
            return headerCell
        } else {
            let taskCell = dataSource.configure(indexPath: indexPath, cellType: HomeCellType.task, tableView: tableView) as! TaskCell
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
                self.dataSource.deleteTask(indexPath:indexPath)
                tableView.reloadData()
                tableView.endUpdates()
            }
        }
    }
}
