//
//  Logout.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

extension HomeViewController {
    
    // MARK: - UI Methods
    // =========================================================================
    // Logs out user by settings root ViewController to Loginview
    
    func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    // Pushes AddTaskViewcontroller to current current view controller on button press
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    func setupNavItems() {
        navigationController?.setupNav()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
}


extension HomeViewController: UIImagePickerControllerDelegate {
    
    // MARK: Public Methods
    // =========================================================================
    // Implements logic for editing task from cell
    
    func tapEdit(atIndex:IndexPath) {
        let tapCell = tableView.cellForRow(at: atIndex) as! TaskCell
        tapped = !tapped
        tapCell.toggled = tapped
        tapCell.taskDescriptionBox.becomeFirstResponder()
        tapCell.saveButton.addTarget(self, action: #selector(toggleForButtonState(sender:)), for: .touchUpInside)
        taskCell(_taskCell: tapCell, didToggleEditState: buttonTapped)
        if tapCell.toggled == true {
            updateDescription(cell: tapCell, for: atIndex.row)
            tapCell.taskDescriptionBox.resignFirstResponder()
        }
    }
    
    
    func updateDescription(cell:TaskCell, for row:Int) {
        var newTask = self.store.tasks[row - 1]
        cell.taskDescriptionBox.text = cell.taskDescriptionBox.text
        newTask.taskDescription = cell.taskDescriptionBox.text
        self.store.firebaseAPI.updateTask(ref: newTask.taskID, taskID: newTask.taskID, task: newTask)
        cell.taskDescriptionLabel.text = cell.taskDescriptionBox.text
    }
    
    
    // MARK: - Delegate Methods
    // =========================================================================
    // If popover is not visible shows popover / if popover is displayed it hides popover
    
    func profilePictureTapped() {
        photoPopover.popView.isHidden = false
        photoPopover.showPopView(viewController: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidden))
        photoPopover.containerView.addGestureRecognizer(tap)
        photoPopover.popView.button.addTarget(self, action: #selector(tapPickPhoto), for: .touchUpInside)
    }
    
    func tapPickPhoto() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        photoPopover.hideView(viewController: self)
    }
    
    func toggleForButtonState(sender:UIButton) {
        buttonTapped = true
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        tapEdit(atIndex: indexPath!)
    }
    
    func taskCell(_taskCell:TaskCell, didToggleEditState editState:Bool) {
        // needs implementation
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        tapEdit(atIndex: tapIndex as IndexPath)
    }
    
    // Hides popover view when operation has ended.
    
    func hidden() {
        photoPopover.hidePopView(viewController: self)
    }
}

extension HomeViewController {
    
    func deleteTask(id:String) {
        self.store.updateUserScore()
        self.store.firebaseAPI.insertUser(user: self.store.currentUser)
        self.store.firebaseAPI.removeTask(ref: id, taskID: id)
    }
    
    func setupTaskCell(taskCell:TaskCell) {
        taskCell.delegate = self
        taskCell.taskDescriptionBox.delegate = self
        taskCell.toggled = tapped
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(sender:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
    }
    
    func configureHeader(headerCell:ProfileHeaderCell) {
        headerCell.delegate = self
        headerCell.emailLabel.isHidden = true
        headerCell.configureCell(autoHeight: UIViewAutoresizing.flexibleHeight)
        if profilePic != nil {
            headerCell.profilePicture.image = self.store.profilePicture
        }
    }
}

extension HomeViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.store.profilePicture = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.store.firebaseAPI.uploadImage(profilePicture: self.store.profilePicture, user: self.store.currentUser, completion: { url in
            self.store.currentUser.profilePicture = url
        })
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func selectImage() {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
}
