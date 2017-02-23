//
//  SharedMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AppFunctions {
    typealias T = BaseCell
    
    @discardableResult
    class func register<T: BaseCell>(tableView: UITableView, cells: [T.Type]) -> T {
        cells.forEach {
            tableView.register($0, forCellReuseIdentifier: $0.cellID)
        }
        return T()
    }
    
    
    class func barSetup(controller: BaseTableViewController) {
        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
        let leftItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
    }
    
    
//    func barSetup(controller: UIViewController) {
//        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
//        let leftItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
//        let rightItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
//        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
//    }
}

