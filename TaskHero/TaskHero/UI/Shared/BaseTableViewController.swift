//
//  BaseTableViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class BaseTableViewController: UITableViewController, UserDataProtocol, Identifiable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToLoginViewController() {
        DispatchQueue.main.async {
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "hasLoggedIn")
            defaults.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = UINavigationController(rootViewController:LoginViewController())
        }
    }
    
    func getLoginViewController() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                goToLoginViewController()
            } catch {
                print("Error")
                goToLoginViewController()
            }
        }
    }
    
    func logoutButtonPressed() {
        DispatchQueue.main.async {
            self.getLoginViewController()
        }
    }
    
    func addTaskButtonTapped() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(AddTaskViewController(), animated:false)
        }
    }
}

