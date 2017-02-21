//
//  SharedMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SharedMethods {
    
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
}
