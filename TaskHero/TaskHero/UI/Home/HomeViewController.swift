//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController, ProfileHeaderCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let store = DataStore.sharedInstance
    let pop = PickerPopMenu()
    var profilePic: UIImage? = nil
    let help = TabviewHelper()
    var tapped: Bool = false
    var buttonTapped: Bool = false
    var indexTap: IndexPath?
    var indexString: String = ""
    let headerView = UIView()
    
    
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
    
    // before view appears fetches user data & loads tasks into datastore befroe reloading tableview - if there are tasks in datastore removes tasks before load
    
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
    
    //if taskref is not nil removes refhandle - necessary to prevent duplicates from being rendered when view reloads.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        if store.refHandle != nil {
            store.tasksRef.removeObserver(withHandle: store.refHandle)
        }
    }
}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
    
}

extension HomeViewController {
    
    // if first row returns profile header cell else returns task cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.delegate = self
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell(user: self.store.currentUser)
            if profilePic != nil {
                headerCell.profilePicture.image = profilePic
            }
            headerCell.contentView.autoresizingMask = UIViewAutoresizing.flexibleHeight
            return headerCell
        } else {
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
            taskCell.delegate = self
            taskCell.toggled = tapped
            
            taskCell.configureCell(task: store.tasks[indexPath.row - 1])
            taskCell.saveButton.tag = indexPath.row
            let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(sender:)))
            tap.accessibilityLabel = String(indexPath.row)
            taskCell.taskCompletedView.addGestureRecognizer(tap)
            return taskCell
        }
    }
    
    // logic for deleting tasks from database when user deletes tableview cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            DispatchQueue.main.async {
                var removeTaskID: String
                if (indexPath.row) == 0 { return
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
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension HomeViewController: TaskCellDelegate {
    
    fileprivate func tapEdit(atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapped = !tapped
        tapCell.toggled! = tapped
        tapCell.buttonToggled = !tapped
        print("Task toggle \(tapCell.toggled)")
        print("Button toggle \(tapCell.buttonToggled)")
        if tapCell.buttonToggled == true {
            
            var newTask = self.store.tasks[atIndex.row - 1]
            newTask.taskDescription = tapCell.taskDescriptionBox.text
            self.store.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
            tapCell.taskDescriptionLabel.text = tapCell.taskDescriptionBox.text
        }
    }
    
    // if popover is not visible shows popover/ if popover is displayed - hides popver
    
    func profilePictureTapped() {
        pop.popView.isHidden = false
        pop.showPopView(viewController: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideView))
        pop.containerView.addGestureRecognizer(tap)
    }
    
    func toggleForButtonState(sender:UIButton) {
        buttonTapped = true
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        tapEdit(atIndex: indexPath!)
    }
    
    // kicks off cycling between taskcell editing states
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        tapEdit(atIndex: tapIndex as IndexPath)
    }
    
    // hides popover view when operation has ended.
    
    func hideView() {
        pop.popView.isHidden = true
        pop.hidePopView(viewController: self)
        pop.popView.layer.opacity = 0
        pop.containerView.layer.opacity = 0
    }
}

extension HomeViewController {
    
    
    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // logs out user by settings root viewcontroller to loginview
    
    func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    // pushes addtaskviewcontroller to current current view controller on button press
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    fileprivate func setupNavItems() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.NavBar.bottomHeight)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
}

