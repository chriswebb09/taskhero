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
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil && (self.store.currentUser != nil) {
                super.viewDidLoad()
                self.view.backgroundColor = UIColor.white
                self.setupControllers()
            } else if self.store.currentUser == nil {
                self.store.fetchUser { user in
                    if user != nil {
                        self.store.currentUser = user
                        super.viewDidLoad()
                        self.view.backgroundColor = UIColor.white
                        self.setupControllers()
                    } else {
                        self.perform(#selector(self.handleLogout), with: nil, afterDelay: 0)
                    }
                }
            } else {
                self.perform(#selector(self.handleLogout), with: nil, afterDelay: 0)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTabBar()
    }
    
    func setupControllers() {
        let homeTab = setupHomeTab(homeVC: HomeViewController())
        let profileTab = setupProfileTab(profileVC: ProfileViewController())
        let taskListTab = setupTaskTab(taskListVC: TaskListViewController())
        let settingsTab = setupSettingsTab(settingsVC: SettingsViewController())
        let controllers = [homeTab, profileTab, taskListTab, settingsTab]
        viewControllers = controllers
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Profile"
        tabBar.items?[2].title = "Tasks"
        tabBar.items?[3].title = "Settings"
        selectedIndex = 0
    }
}

extension TabBarController {
    
    func setupHomeTab(homeVC:HomeViewController) -> UINavigationController {
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "house-white-2")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "house-lightblue")?.withRenderingMode(.alwaysTemplate))
        homeVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
        
        let homeTab = UINavigationController(rootViewController: homeVC)
        homeTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        homeTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.Font.helveticaThin, size: 22)!]
        homeTab.navigationBar.barTintColor = Constants.navbarBarTintColor
        homeTab.navigationBar.topItem?.title = "TaskHero"
        return homeTab
    }
    
    func setupProfileTab(profileVC:ProfileViewController) -> UINavigationController {
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-lightblue")?.withRenderingMode(.alwaysTemplate))
        profileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        profileVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        profileVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
        
        let profileTab = UINavigationController(rootViewController: profileVC)
        profileTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        profileTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.Font.helveticaThin, size: 22)!]
        profileTab.navigationBar.barTintColor = Constants.navbarBarTintColor
        profileTab.navigationBar.topItem?.title = "Profile"
        return profileTab
    }
    
    func setupTaskTab(taskListVC:TaskListViewController) -> UINavigationController {
        taskListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tasklist-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list-lightblue")?.withRenderingMode(.alwaysTemplate))
        taskListVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        taskListVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        taskListVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
        
        let taskListTab = UINavigationController(rootViewController: taskListVC)
        taskListTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        taskListTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.Font.helveticaThin, size: 22)!]
        taskListTab.navigationBar.barTintColor = Constants.navbarBarTintColor
        taskListTab.navigationBar.topItem?.title = "TaskList"
        return taskListTab
    }
    
    
    func setupSettingsTab(settingsVC:SettingsViewController) -> UINavigationController {
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-2-white-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-lightblue")?.withRenderingMode(.alwaysTemplate))
        settingsVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        settingsVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        settingsVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
        
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        settingsTab.navigationBar.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
        settingsTab.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: Constants.Font.helveticaThin, size: 22)!]
        settingsTab.navigationBar.barTintColor = Constants.navbarBarTintColor
        settingsTab.navigationBar.topItem?.title = "Settings"
        return settingsTab
    }
    
    func setupTabBar() {
        let tabBarHeight = view.frame.height * Constants.Tabbar.tabbarFrameHeight
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.tintColor = Constants.Tabbar.tabbarTintColor
        tabBar.barTintColor = Constants.Tabbar.tabbarColor
        tabBar.isTranslucent = true
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginController
    }
}
