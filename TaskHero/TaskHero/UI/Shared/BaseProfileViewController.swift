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
        UINavigationController.photoTapped(controller: self)
    }
    
//    class func photoTapped(controller: BaseProfileViewController) {
//        controller.picker.allowsEditing = false
//        controller.picker.sourceType = .photoLibrary
//        controller.present(controller.picker, animated: true, completion: nil)
//        controller.photoPopover.hideView(viewController: controller)
//    }
    
}

protocol ProfileViewable {
    var picker: UIImagePickerController { get set }
    var photoPopover: PhotoPickerPopover { get set }
    func logoutButtonPressed()
    func addTaskButtonTapped()
    func tapPickPhoto(_ sender: UIButton)
}

extension BaseViewController {
    class func profilePictureTapped(controller: BaseProfileViewController) {
        controller.photoPopover.showPopView(viewController: controller)
        controller.photoPopover.photoPopView.button.addTarget(controller, action: #selector(controller.tapPickPhoto(_:)), for: .touchUpInside)
    }
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
