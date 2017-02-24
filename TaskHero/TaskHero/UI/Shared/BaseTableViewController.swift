//
//  BaseTableViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

protocol Identifiable {
    typealias T = BaseCell
    func register<T: BaseCell>(tableView: UITableView, cells: [T.Type]) -> T
}

extension Identifiable {
    @discardableResult
    func register<T: BaseCell>(tableView: UITableView, cells: [T.Type]) -> T {
        cells.forEach {
            tableView.register($0, forCellReuseIdentifier: $0.cellID)
        }
        return T()
    }
}

protocol UserDataProtocol {
    func fetchUser(tableView: UITableView)
}

extension UserDataProtocol {
    func fetchUser(tableView: UITableView) {
        UserDataStore.sharedInstance.firebaseAPI.fetchUserData() { user in
            UserDataStore.sharedInstance.firebaseAPI.fetchTaskList() { taskList in
                UserDataStore.sharedInstance.tasks = taskList
                DispatchQueue.main.async {
                    UserDataStore.sharedInstance.currentUser = user
                    tableView.reloadOnMain()
                }
            }
        }
    }
}

extension BaseTableViewController {
    class func imageSelection(controller: BaseProfileViewController) {
        controller.picker.allowsEditing = false
        controller.picker.sourceType = .photoLibrary
        controller.present(controller.picker, animated: true, completion: nil)
        controller.photoPopover.hideView(viewController: controller)
    }

}

extension BaseTableViewController {
    

}

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

