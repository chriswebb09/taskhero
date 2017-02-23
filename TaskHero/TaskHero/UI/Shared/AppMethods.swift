//
//  SharedMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

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

class AppFunctions {
    
    
    typealias B = BaseTableViewController
//    
//    @discardableResult
//    class func register<T: BaseCell>(tableView: UITableView, cells: [T.Type]) -> T {
//        cells.forEach {
//            tableView.register($0, forCellReuseIdentifier: $0.cellID)
//        }
//        return T()
//    }
//    
    
    
    @discardableResult
    class func barSetup<B: BaseTableViewController>(controller: B) -> B {
        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
        let leftItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
        return controller
    }
    
    
    class func imageSelection(controller: BaseProfileViewController) {
        controller.picker.allowsEditing = false
        controller.picker.sourceType = .photoLibrary
        controller.present(controller.picker, animated: true, completion: nil)
        controller.photoPopover.hideView(viewController: controller)
    }
    
    
    class func photoTapped(controller: BaseProfileViewController) {
        controller.picker.allowsEditing = false
        controller.picker.sourceType = .photoLibrary
        controller.present(controller.picker, animated: true, completion: nil)
        controller.photoPopover.hideView(viewController: controller)
    }
    
    class func profilePictureTapped(controller: BaseProfileViewController) {
        controller.photoPopover.showPopView(viewController: controller)
        controller.photoPopover.photoPopView.button.addTarget(controller, action: #selector(controller.tapPickPhoto(_:)), for: .touchUpInside)
    }
    
    class func photoForPicker(controller: BaseProfileViewController, info: [String: Any], viewModel: BaseProfileViewModel) {
        var viewModel = viewModel
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewModel.profilePic = image
        } else {
            print("Something went wrong")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    class func setupTableView(tableView: UITableView, view: UIView) {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .singleLineEtched
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
}

