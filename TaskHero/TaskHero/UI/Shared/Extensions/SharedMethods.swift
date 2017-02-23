//
//  SharedMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SharedMethods {
    
    typealias B = BaseTableViewController
    
    @discardableResult
    class func barSetup<B: BaseTableViewController>(controller: B) -> B {
        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
        let leftItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
        return controller
    }
    
    
    class func getLeftBarItem(selector: Selector, viewController: UIViewController) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Log Out", style: .done, target: viewController, action: selector)
    }
    
    class func getRightBarItem(image: UIImage?, selector: Selector, viewController: UIViewController) -> UIBarButtonItem {
        return  UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .done, target: viewController, action: selector)
    }
    
    class func getAddTaskImage() -> UIImage {
        return UIImage(named: "add-white-2")!
    }
    
    class func getBarItemAttributes() -> [String: Any] {
        return [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium!]
    }
    
    class func setupNavItems(navigationItem: UINavigationItem, leftBarItem: UIBarButtonItem, rightItem: UIBarButtonItem) {
        let leftBarAttributes: [String: Any] = SharedMethods.getBarItemAttributes()
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(leftBarAttributes, for: .normal)
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
    
    class func loadTabBar(tabBar:TabBarController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    
    class func loginDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hasLoggedIn")
        defaults.synchronize()
    }

}
