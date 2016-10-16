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
        tabBar.tintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        tabBar.barTintColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
    }
    
    func setupControllers() {
        
        let homeVC = HomeViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "house-white-2")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "house-blue-2")?.withRenderingMode(.alwaysTemplate))
        homeVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)], for:.selected)
        
        let homeTab = UINavigationController(rootViewController: homeVC)
        homeTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        homeTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        homeTab.navigationBar.barTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        //homeTab.navigationBar.barTintColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        homeTab.navigationBar.topItem?.title = "TaskHero"
        
        
        
        let profileVC = ProfileViewController()
        
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-blue")?.withRenderingMode(.alwaysTemplate))
        profileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        profileVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        profileVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)], for:.selected)
        
        let profileTab = UINavigationController(rootViewController: profileVC)
        profileTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        profileTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        profileTab.navigationBar.barTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        profileTab.navigationBar.topItem?.title = "Profile"
        
        
        let taskListVC = TaskListViewController()
        
        taskListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tasklist-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tasklist")?.withRenderingMode(.alwaysTemplate))
        taskListVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        taskListVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        taskListVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)], for:.selected)
        
        let taskListTab = UINavigationController(rootViewController: taskListVC)
        taskListTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        taskListTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        taskListTab.navigationBar.barTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        taskListTab.navigationBar.topItem?.title = "TaskList"
        
        
        
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-2-white-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-2-blue")?.withRenderingMode(.alwaysTemplate))
        settingsVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        settingsVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        settingsVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)], for:.selected)
        
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        settingsTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        settingsTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 22)!]
        settingsTab.navigationBar.barTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        settingsTab.navigationBar.topItem?.title = "Settings"
        
        
        
        
        
        
        
        
        let controllers = [homeTab, profileTab, taskListTab, settingsTab]
        viewControllers = controllers
        
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Profile"
        tabBar.items?[2].title = "Tasks"
        tabBar.items?[3].title = "Settings"
        selectedIndex = 0
    }
    
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
    }
}
