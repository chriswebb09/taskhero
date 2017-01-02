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
    let helper = Helper()
    
}

extension HomeViewController: UINavigationControllerDelegate {
    
    // ==============================
    // MARK: - Initialization
    // ==============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        edgesForExtendedLayout = []
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
        setupView()
    }
    
    private func setupView() {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.setupHelper()
        tableView.estimatedRowHeight = view.frame.height / 4
        setupNavItems()
    }
    
    // Before view appears fetches user data & loads tasks into datastore befroe reloading tableview
    // If there are tasks in datastore removes tasks before load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        getTasks()
    }
    
    // If taskref is not nil removes refhandle - necessary to prevent duplicates from being rendered when view reloads.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        if self.store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
    
    private func getTasks() {
        self.store.setupStore()
        self.store.firebaseAPI.fetchTasks() { task in
            self.store.tasks.append(task)
            self.store.currentUser.tasks?.append(task)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: ProfileHeaderCellDelegate, UITextViewDelegate, TaskCellDelegate {
    
    // MARK: UITableViewController Methods
    // =========================================================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.store.tasks.count < 1 {
            return 1
        } else {
            return self.store.tasks.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    // If first row returns profile header cell else returns task cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSource = HomeViewControllerDataSource()
        dataSource.indexPath = indexPath
        if indexPath.row == 0 {
            let headerCell = dataSource.configure(indexPath: indexPath, cellType: CellType.header) as! ProfileHeaderCell
            configureHeader(headerCell: headerCell)
            return headerCell
        } else {
            let taskCell = dataSource.configure(indexPath: indexPath, cellType: CellType.task) as! TaskCell
            setupTaskCell(taskCell: taskCell)
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
                let removeTaskID: String = self.store.tasks[indexPath.row - 1].taskID
                self.deleteTask(id: removeTaskID)
                self.store.tasks.remove(at: indexPath.row - 1)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            tableView.reloadData()
        }
    }
}
