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
    
    // MARK: Public Methods
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
    
    // MARK: - Header and Task cell Delegate Methods
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
        print("inside toggleForButtonState")
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        helpers.tapEdit(tableView: tableView, atIndex: indexPath!)
    }
    
    func taskCell(didToggleEditState editState:Bool) {
        //
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        helpers.tapEdit(tableView:tableView, atIndex: tapIndex)
        //tapEdit(atIndex: tapIndex as IndexPath)
    }
    
    // Hides popover view when operation has ended.
    
    func hidden() {
        photoPopover.hidePopView(viewController: self)
    }
}

extension HomeViewController {
    // Implements logic for editing task from cell
    
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
    
    // MARK: - ImagePicker delegate methods
    // =========================================================================
    
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
    
    fileprivate func selectImage() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
}
