//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController, ProfileHeaderCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // MARK: Internal Properties
    
    let store = DataStore.sharedInstance
    let photoPopover = PhotoPickerPopover()
    var profilePic: UIImage? = nil
    let help = TabviewHelper()
    var tapped: Bool = false
    var buttonTapped: Bool = false
    var indexTap: IndexPath?
    var indexString: String = ""
    let headerView = UIView()
    
    
}

extension HomeViewController {
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
        view.backgroundColor = Constants.tableViewBackgroundColor
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        
        help.setupTableView(tableView: tableView)
        tableView.estimatedRowHeight = view.frame.height / 4
        setupNavItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Before view appears fetches user data & loads tasks into datastore befroe reloading tableview
    // If there are tasks in datastore removes tasks before load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.store.fetchUserData()
        self.store.tasks.removeAll()
        if self.store.currentUser.tasks != nil {
            self.store.currentUser.tasks?.removeAll()
        }
        self.store.fetchTasks(completion: { task in
            self.store.tasks.append(task)
            self.store.currentUser.tasks!.append(task)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // If taskref is not nil removes refhandle
    // necessary to prevent duplicates from being rendered when view reloads.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        if store.refHandle != nil {
            store.tasksRef.removeObserver(withHandle: store.refHandle)
        }
    }
}

extension HomeViewController: UITextViewDelegate {
    
    // MARK: UITableViewController Methods
    
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
        if indexPath.row == 0 {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.delegate = self
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell()
            if profilePic != nil {
                headerCell.profilePicture.image = profilePic
            }
            headerCell.contentView.autoresizingMask = UIViewAutoresizing.flexibleHeight
            return headerCell
        } else {
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
            taskCell.delegate = self
            taskCell.taskDescriptionBox.delegate = self
            taskCell.toggled = tapped
            taskCell.configureCell(task: store.tasks[indexPath.row - 1])
            taskCell.saveButton.tag = indexPath.row
            let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(sender:)))
            taskCell.taskCompletedView.addGestureRecognizer(tap)
            return taskCell
        }
    }
    
    // Logic for deleting tasks from database when user deletes tableview cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            DispatchQueue.main.async {
                var removeTaskID: String
                if indexPath.row == 0 { return
                } else {
                    removeTaskID = self.store.tasks[indexPath.row - 1].taskID
                    self.store.currentUser.experiencePoints += self.store.tasks[indexPath.row - 1].pointValue
                    self.store.currentUser.numberOfTasksCompleted += 1
                    self.store.insertUser(user: self.store.currentUser) }
                
                self.store.removeTask(ref: removeTaskID, taskID: removeTaskID)
                self.store.tasks.remove(at: indexPath.row - 1)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.endUpdates()
            }
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class
            // insert it into the array, and add a new row to the table view.
        }
    }
}

extension HomeViewController: TaskCellDelegate {
    
    // MARK: Public Methods
    // Implements logic for editing task from cell
    
    func tapEdit(atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapped = !tapped
        
        tapCell.toggled! = tapped
        tapCell.buttonToggled = !tapped
        tapCell.taskDescriptionBox.becomeFirstResponder()
        tapCell.taskDescriptionBox.text = store.currentUser.tasks?[atIndex.row - 1].taskDescription
        print("Task toggle \(tapCell.toggled)")
        print("Button toggle \(tapCell.buttonToggled)")
        if tapCell.buttonToggled == true {
            tapCell.taskDescriptionBox.text = tapCell.taskDescriptionBox.text
            var newTask = self.store.tasks[atIndex.row - 1]
            newTask.taskDescription = tapCell.taskDescriptionBox.text
            self.store.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            tapCell.taskDescriptionLabel.text = tapCell.taskDescriptionBox.text
            tapCell.taskDescriptionBox.resignFirstResponder()
        }
    }
    
    // MARK: - Delegate Methods
    
    // If popover is not visible shows popover
    // if popover is displayed it hides popover
    
    func profilePictureTapped() {
        photoPopover.popView.isHidden = false
        photoPopover.showPopView(viewController: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideView))
        photoPopover.containerView.addGestureRecognizer(tap)
    }
    
    func toggleForButtonState(sender:UIButton) {
        buttonTapped = true
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        tapEdit(atIndex: indexPath!)
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        tapEdit(atIndex: tapIndex as IndexPath)
    }
    
    // Hides popover view when operation has ended.
    
    func hideView() {
        photoPopover.popView.isHidden = true
        photoPopover.hidePopView(viewController: self)
        photoPopover.popView.layer.opacity = 0
        photoPopover.containerView.layer.opacity = 0
    }
}

