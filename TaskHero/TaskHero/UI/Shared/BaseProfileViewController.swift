//
//  BaseProfileViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class BaseProfileViewController: BaseTableViewController, ProfileViewable{
    
    internal var photoPopover: PhotoPickerPopover = PhotoPickerPopover()
    
    
    var picker: UIImagePickerController = UIImagePickerController()
    
    override func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    internal func tapPickPhoto(_ sender: UIButton) {
        SharedMethods.photoTapped(controller: self)
    }
    
}

protocol ProfileViewable {
    var picker: UIImagePickerController { get set }
    var photoPopover: PhotoPickerPopover { get set }
    func logoutButtonPressed()
    func addTaskButtonTapped()
    func tapPickPhoto(_ sender: UIButton)
}

extension ProfileViewable {
    
    func logoutButtonPressed() {
        // not implemented
    }
    
    func addTaskButtonTapped() {
        // not implemented
    }
    
    func tapPickPhoto(_ sender: UIButton) {
        // AppFunctions.photoTapped(controller: self)
        //homeViewModel.photoTapped(controller: self)
    }
    
}
