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
    
    // self.perform(#selector(self.helpers.handleLogout), with: nil, afterDelay: 0)
    
    // ====================
    // MARK: - Properties
    // ====================
    
    let manager = AppManager.sharedInstance
    let store = DataStore.sharedInstance
    let helpers = Helpers()
    
    // =========================
    // MARK: - Initialization
    // =========================
    
    override func viewDidLoad() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            self.view.backgroundColor = UIColor.white
            if user != nil && (self.store.currentUser != nil) {
                DispatchQueue.main.async {
                    self.setupTabs()
                }
                
            } else if self.store.currentUser == nil {
                self.getUser()
                DispatchQueue.main.async {
                    self.setupTabs()
                }
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        helpers.setupTabBar(tabBar:tabBar, view:view)
    }
    
    
    func getUser() {
        self.store.firebaseAPI.fetchUserData { user in
            self.store.currentUser = user
        }
    }
    
    func setupTabs() {
        super.viewDidLoad()
        self.setupControllers()
    }
    
}

extension TabBarController {
    
    // ===============================
    // MARK: - Setup ViewControllers
    // ===============================
    
    fileprivate func setupControllers() {
        DispatchQueue.main.async {
            let homeTab = self.setupHomeTab(homeVC: HomeViewController())
            let profileTab = self.setupProfileTab(profileVC: ProfileViewController())
            let taskListTab = self.setupTaskTab(taskListVC: TaskListViewController())
            let settingsTab = self.setupSettingsTab(settingsVC: SettingsViewController())
            let controllers = [homeTab, profileTab, taskListTab, settingsTab]
            
            self.viewControllers = controllers
            self.tabBar.items?[0].title = "Home"
            self.tabBar.items?[1].title = "Profile"
            self.tabBar.items?[2].title = "Tasks"
            self.tabBar.items?[3].title = "Settings"
            self.selectedIndex = 0
            
        }
    }
}

extension TabBarController {
    
    fileprivate func setupHomeTab(homeVC:HomeViewController) -> UINavigationController {
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "house-white-2")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "house-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: homeVC.tabBarItem)
        let homeTab = UINavigationController(rootViewController: homeVC)
        helpers.configureNav(nav: homeTab.navigationBar, view:view)
        homeTab.navigationBar.topItem?.title = "TaskHero"
        return homeTab
    }
    
    fileprivate func setupProfileTab(profileVC:ProfileViewController) -> UINavigationController {
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: profileVC.tabBarItem)
        let profileTab = UINavigationController(rootViewController: profileVC)
        helpers.configureNav(nav:profileTab.navigationBar, view:profileVC.view)
        profileTab.navigationBar.topItem?.title = "Profile"
        return profileTab
    }
    
    fileprivate func setupTaskTab(taskListVC:TaskListViewController) -> UINavigationController {
        taskListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tasklist-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: taskListVC.tabBarItem)
        let taskListTab = UINavigationController(rootViewController: taskListVC)
        helpers.configureNav(nav: taskListTab.navigationBar, view:taskListVC.view)
        taskListTab.navigationBar.topItem?.title = "TaskList"
        return taskListTab
    }
    
    fileprivate func setupSettingsTab(settingsVC:SettingsViewController) -> UINavigationController {
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-2-white-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: settingsVC.tabBarItem)
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        helpers.configureNav(nav: settingsTab.navigationBar, view:settingsVC.view)
        settingsTab.navigationBar.topItem?.title = "Settings"
        return settingsTab
    }
}

extension TabBarController {
    
    func configureTabBarItem(item:UITabBarItem) {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
    }
}
