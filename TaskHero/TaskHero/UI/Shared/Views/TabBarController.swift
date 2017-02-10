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
    // MARK: - Properties
    
    let store = UserDataStore.sharedInstance
    let helpers = Helpers()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            self.view.backgroundColor = UIColor.white
            if user != nil && (self.store.currentUser != nil) {
                self.setupTabs()
            } else if self.store.currentUser == nil {
                DispatchQueue.global(qos: .background).async {
                    self.getUser()
                    DispatchQueue.main.async {
                        self.setupTabs()
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Helpers.setupTabBar(tabBar:tabBar, view:view)
    }
    
    func getUser() {
        store.firebaseAPI.fetchUserData { user in
            self.store.currentUser = user
        }
    }
    
    func setupTabs() {
        super.viewDidLoad()
        setupControllers()
    }
    
    // MARK: - Setup ViewControllers
    
    fileprivate func setupControllers() {
        let homeTab = self.setupHomeTab(homeVC: HomeViewController())
        let profileTab = self.setupProfileTab(profileVC: ProfileViewController())
        let taskListTab = self.setupTaskTab(taskListVC: TaskListViewController())
        let settingsTab = self.setupSettingsTab(settingsVC: SettingsViewController())
        let controllers = [homeTab, profileTab, taskListTab, settingsTab]
        setTabTitles(controllers: controllers)
    }
    
    private func setTabTitles(controllers: [UINavigationController]) {
        viewControllers = controllers
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Profile"
        tabBar.items?[2].title = "Tasks"
        tabBar.items?[3].title = "Settings"
        selectedIndex = 0
    }
    
    fileprivate func setupHomeTab(homeVC: HomeViewController) -> UINavigationController {
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "house-white-2")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "house-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: homeVC.tabBarItem)
        let homeTab = UINavigationController(rootViewController: homeVC)
        configureNav(nav: homeTab.navigationBar, view:view)
        homeTab.navigationBar.topItem?.title = "TaskHero"
        return homeTab
    }
    
    fileprivate func setupProfileTab(profileVC: ProfileViewController) -> UINavigationController {
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "avatar-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "avatar-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: profileVC.tabBarItem)
        let profileTab = UINavigationController(rootViewController: profileVC)
        configureNav(nav:profileTab.navigationBar, view:profileVC.view)
        profileTab.navigationBar.topItem?.title = "Profile"
        return profileTab
    }
    
    fileprivate func setupTaskTab(taskListVC: TaskListViewController) -> UINavigationController {
        taskListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tasklist-white")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: taskListVC.tabBarItem)
        let taskListTab = UINavigationController(rootViewController: taskListVC)
        configureNav(nav: taskListTab.navigationBar, view:taskListVC.view)
        taskListTab.navigationBar.topItem?.title = "Task List"
        return taskListTab
    }
    
    fileprivate func setupSettingsTab(settingsVC: SettingsViewController) -> UINavigationController {
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settings-2-white-1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settings-lightblue")?.withRenderingMode(.alwaysTemplate))
        configureTabBarItem(item: settingsVC.tabBarItem)
        let settingsTab = UINavigationController(rootViewController: settingsVC)
        configureNav(nav: settingsTab.navigationBar, view:settingsVC.view)
        settingsTab.navigationBar.topItem?.title = "Settings"
        return settingsTab
    }
    
    func configureNav(nav:UINavigationBar, view: UIView) {
        nav.titleTextAttributes = Constants.Tabbar.navbarAttributedText
        nav.barTintColor = Constants.Tabbar.tint
        nav.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height * 1.2)
    }
    
    
    func configureTabBarItem(item: UITabBarItem) {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)], for:.selected)
    }
}
