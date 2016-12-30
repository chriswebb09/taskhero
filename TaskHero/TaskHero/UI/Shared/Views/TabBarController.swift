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
    
    //let store = DataStore.sharedInstance
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil && (self.store.currentUser != nil) {
                super.viewDidLoad()
                self.setupControllers()
                self.view.backgroundColor = UIColor.white
            } else if self.store.currentUser == nil { self.store.firebaseAPI.fetchUser(completion: { user in
                self.store.currentUser = user
                super.viewDidLoad()
                self.setupControllers()
                self.view.backgroundColor = UIColor.white
                })
            } else { self.perform(#selector(self.handleLogout), with: nil, afterDelay: 0) }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTabBar()
    }
    
    fileprivate func setupControllers() {
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
    
    fileprivate func setupHomeTab(homeVC:HomeViewController) -> UINavigationController {
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "house-white-2")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "house-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: homeVC.tabBarItem)
        let homeTab = UINavigationController(rootViewController: homeVC)
        configureNav(nav: homeTab.navigationBar)
        homeTab.navigationBar.topItem?.title = "TaskHero"
        return homeTab
    }
    
    fileprivate func setupProfileTab(profileVC:ProfileViewController) -> UINavigationController {
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: profileVC.tabBarItem)
        let profileTab = UINavigationController(rootViewController: profileVC)
        configureNav(nav:  profileTab.navigationBar)
        profileTab.navigationBar.topItem?.title = "Profile"
        return profileTab
    }
    
    fileprivate func setupTaskTab(taskListVC:TaskListViewController) -> UINavigationController {
        taskListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tasklist-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: taskListVC.tabBarItem)
        let taskListTab = UINavigationController(rootViewController: taskListVC)
        configureNav(nav: taskListTab.navigationBar)
        taskListTab.navigationBar.topItem?.title = "TaskList"
        return taskListTab
    }
    
    fileprivate func setupSettingsTab(settingsVC:SettingsViewController) -> UINavigationController {
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-2-white-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: settingsVC.tabBarItem)
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        configureNav(nav: settingsTab.navigationBar)
        settingsTab.navigationBar.topItem?.title = "Settings"
        return settingsTab
    }
}

extension TabBarController {
    
    func configureNav(nav:UINavigationBar) {
        nav.titleTextAttributes = Constants.Tabbar.navbarAttributedText
        nav.barTintColor = Constants.Tabbar.navbarBarTintColor
        nav.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
    }
    
    func configureTabBarItem(item:UITabBarItem) {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
    }
    
    func setupTabBar() {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.height * Constants.Tabbar.tabbarFrameHeight
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        
        tabBar.frame = tabFrame
        tabBar.isTranslucent = true
        tabBar.tintColor = Constants.Tabbar.tabbarTintColor
        tabBar.barTintColor = Constants.Tabbar.tabbarColor
    }
    
    func handleLogout() {
        do {
            DefaultsData().setLoggedInKey(userState: false)
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }; let loginController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginController
    }
    
}
