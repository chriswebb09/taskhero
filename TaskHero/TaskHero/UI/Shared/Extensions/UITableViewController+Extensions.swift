//
//  UIViewController+Extensions.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit





extension UINavigationController {
    
    class func setupNavItems(navigationItem: UINavigationItem, leftBarItem: UIBarButtonItem, rightItem: UIBarButtonItem) {
        let leftBarAttributes: [String: Any] = UINavigationController.getBarItemAttributes()
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(leftBarAttributes, for: .normal)
    }
    
    
    class func photoTapped(controller: BaseProfileViewController) {
        controller.picker.allowsEditing = false
        controller.picker.sourceType = .photoLibrary
        controller.present(controller.picker, animated: true, completion: nil)
        controller.photoPopover.hideView(viewController: controller)
    }
    
    class func getLeftBarItem(selector: Selector, viewController: UIViewController) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Log Out", style: .done, target: viewController, action: selector)
    }
    
    class func getRightBarItem(image: UIImage?, selector: Selector, viewController: UIViewController) -> UIBarButtonItem {
        return  UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .done, target: viewController, action: selector)
    }
    
    class func getBarItemAttributes() -> [String: Any] {
        return [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!]
    }
    
}

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


final class SharedMethods {
    
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

