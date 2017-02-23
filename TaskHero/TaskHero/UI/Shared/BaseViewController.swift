//
//  BaseViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func logoutButtonPressed() {
        
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}


class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func logoutButtonPressed() {
        
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}


class BaseProfileViewController: BaseTableViewController {
    
    var picker: UIImagePickerController = UIImagePickerController()
    let photoPopover = PhotoPickerPopover()
    override func logoutButtonPressed() {
        
    }
    
    override func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    internal func tapPickPhoto(_ sender: UIButton) {
        AppFunctions.photoTapped(controller: self)
        //homeViewModel.photoTapped(controller: self)
    }
    
}

