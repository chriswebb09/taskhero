//
//  UIViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/24/17.
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

protocol Loginable {
   func setLoginViewController()
}

extension Loginable {
    func setLoginViewController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:LoginViewController())
    }
}

extension BaseViewController {
    class func profilePictureTapped(controller: BaseProfileViewController) {
        controller.photoPopover.showPopView(viewController: controller)
        controller.photoPopover.photoPopView.button.addTarget(controller, action: #selector(controller.tapPickPhoto(_:)), for: .touchUpInside)
    }
}

extension BaseViewController {
    
    class func photoForPicker(controller: BaseProfileViewController, info: [String: Any]) -> UIImage? {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            controller.dismiss(animated: true, completion: nil)
            return image
        } else {
            print("Something went wrong")
            controller.dismiss(animated: true, completion: nil)
            return nil
        }
    }
}
