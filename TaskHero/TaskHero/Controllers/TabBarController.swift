//
//  TabBarController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let tabBarHeight = view.frame.height * 0.092
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.tintColor = UIColor(red:0.08, green:0.67, blue:0.95, alpha:1.0)
        tabBar.barTintColor = UIColor.black
    }
    
    func setupControllers() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home-unselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home-selected")?.withRenderingMode(.alwaysTemplate))
        
        homeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        
        let homeTab = UINavigationController(rootViewController: homeVC)
        
        homeTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        homeTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        homeTab.navigationBar.barTintColor = UIColor.white
        homeTab.navigationBar.topItem?.title = "TaskTiger Home"
    }
}
    
