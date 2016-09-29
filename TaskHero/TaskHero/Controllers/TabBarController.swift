//
//  TabBarController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            super.viewDidLoad()
            view.backgroundColor = UIColor.white
            setupControllers()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let tabBarHeight = view.frame.height * 0.08
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.tintColor = UIColor(red:0.08, green:0.67, blue:0.95, alpha:1.0)
        
        tabBar.barTintColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
    }
    
    func setupControllers() {
        
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()
        let settingsVC = SettingsViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home-unselected-gray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home-selected")?.withRenderingMode(.alwaysTemplate))
        
        homeVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        let homeTab = UINavigationController(rootViewController: homeVC)
        
        homeTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        homeTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        homeTab.navigationBar.barTintColor = UIColor.white
        homeTab.navigationBar.topItem?.title = "TaskTiger Home"
        
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-unselected-gray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-selected-darker")?.withRenderingMode(.alwaysTemplate))
        
        profileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        let profileTab = UINavigationController(rootViewController: profileVC)
        profileTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        profileTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        profileTab.navigationBar.barTintColor = UIColor.white
        profileTab.navigationBar.topItem?.title = "Profile"
        
        
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-1-unselected-gray")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-1-selected")?.withRenderingMode(.alwaysTemplate))
        
        settingsVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        settingsTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        settingsTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        settingsTab.navigationBar.barTintColor = UIColor.white
        settingsTab.navigationBar.topItem?.title = "Profile"
        
        let controllers = [homeTab, profileTab, settingsTab]
        
        viewControllers = controllers
        
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Profile"
        tabBar.items?[2].title = "Settings"
        
        selectedIndex = 0
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //...
    }
}

