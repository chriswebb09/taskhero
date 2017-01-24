//
//  Logout.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

/*
 Extension that adds on features - sets up action for logout button press,
 add task button press and adds these as selectors on
 navigation items which are added to navigation controller.
 */

extension HomeViewController {
    
    // MARK: Selector Methods
    /* Logs out user by settings root ViewController to Loginview */
    
    func logoutButtonPressed() {
        let loginVC = LoginViewController()
        let rootNC = UINavigationController(rootViewController:loginVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDataStore.sharedInstance.logout()
        appDelegate.window?.rootViewController = rootNC
    }
    
    /* Pushes AddTaskViewcontroller to current current view controller on button press */
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    // MARK: - Nav Items
    /* Adds two methods above to as selector methods in navigation items and adds navigation items to navigation controller */
    
    func addNavItemsToController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
    }
    
    /* Hides popover view when operation has ended. */
    
    public func hidePopoverView() {
        photoPopover.hidePopView(viewController: self)
    }
    
    // Task cell Delegate Methods - Mainly toggling UI for edit state
    // MARK: - TaskCell
    /* Method toggles UI states from editing to not editing when save is pressed */
    
    func toggleForButtonState(_ sender:UIButton) {
        print("inside toggleForButtonState")
        print("-----------------------------")
        let superview = sender.superview
        let cell = superview?.superview as? TaskCell
        let indexPath = tableView.indexPath(for: cell!)
        dataSource.tapEdit(viewController: self, tableView: tableView, atIndex: indexPath!)
    }
    
    /* Kicks off cycling between taskcell editing states */
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        dataSource.tapEdit(viewController:self, tableView:tableView, atIndex: tapIndex)
    }
}

// Extension for header cell delegate methods and UIImagePicker implementation - mainly for ProfilePicture

extension HomeViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Header cell Delegate Methods
    // FIXME: - Fix so that image picker can be dismissed by clicking on popover containerview - Add profile picture storage methods
    
    func tapPickPhoto(_ sender:UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        photoPopover.hideView(viewController: self)
    }
    
    // MARK: - Popover
    /* If popover is not visible shows popover / if popover is displayed it hides popover */
    
    public func profilePictureTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidePopoverView))
        photoPopover.popView.isHidden = false
        photoPopover.showPopView(viewController: self)
        photoPopover.containerView.addGestureRecognizer(tap)
        photoPopover.photoPopView.button.addTarget(self, action: #selector(tapPickPhoto(_:)), for: .touchUpInside)
    }
    
}



