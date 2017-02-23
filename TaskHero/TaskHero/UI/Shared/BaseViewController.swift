//
//  BaseViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

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


class BaseProfileViewController: BaseTableViewController, ProfileViewable {
    
    internal var photoPopover: PhotoPickerPopover = PhotoPickerPopover()

    
    var picker: UIImagePickerController = UIImagePickerController()
   
//    override func logoutButtonPressed() {
//        let defaults = UserDefaults.standard
//        defaults.set(false, forKey: "hasLoggedIn")
//        defaults.synchronize()
//        let loginVC = UINavigationController(rootViewController:LoginViewController())
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = loginVC
//    }
    
    override func logoutButtonPressed() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.synchronize()
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let loginVC = UINavigationController(rootViewController:LoginViewController())
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = loginVC
            } catch {
                print("Error")
                let loginVC = UINavigationController(rootViewController:LoginViewController())
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = loginVC
            }
        }
    }
    
    override func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    internal func tapPickPhoto(_ sender: UIButton) {
        AppFunctions.photoTapped(controller: self)
        //homeViewModel.photoTapped(controller: self)
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

