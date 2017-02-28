//
//  UIViewController+Extensions.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UITableViewController {
    class func profilePictureTapped(controller: BaseProfileViewController) {
        controller.photoPopover.showPopView(viewController: controller)
        controller.photoPopover.photoPopView.button.addTarget(controller, action: #selector(controller.tapPickPhoto(_:)), for: .touchUpInside)
    }
    
    class func photoTapped(controller: BaseProfileViewController) {
        controller.picker.allowsEditing = false
        controller.picker.sourceType = .photoLibrary
        controller.present(controller.picker, animated: true, completion: nil)
        controller.photoPopover.hideView(viewController: controller)
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
    typealias B = BaseTableViewController
    
    @discardableResult
    class func barSetup<B: BaseTableViewController>(controller: B) -> B {
        let rightBarImage: UIImage = UIImage.getAddTaskImage()!
        let leftItem = UINavigationController.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightItem = UINavigationController.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        UINavigationController.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
        return controller
    }
}
