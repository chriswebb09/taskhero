//
//  UINavigationController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/26/17.
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
