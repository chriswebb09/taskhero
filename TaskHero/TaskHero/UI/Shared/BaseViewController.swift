//
//  BaseViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

protocol Loginable {
    //func getLoginViewController()
}

extension Loginable {
    
    func setLoginViewController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:LoginViewController())
    }
    
    //    typealias B = BaseTableViewController
    //
    //    @discardableResult
    //    static func barSetup<B: BaseTableViewController>(controller: B) -> B {
    //        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
    //        let leftItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
    //        let rightItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
    //        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
    //        return controller
    //    }
}

class BaseViewController: UIViewController, Loginable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setLoginViewController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:LoginViewController())
    }
    
    func setupDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.synchronize()
    }
    
    typealias B = BaseTableViewController
    
    @discardableResult
    static func barSetup<B: BaseTableViewController>(controller: B) -> B {
        let rightBarImage: UIImage = UIImage.getAddTaskImage()!
        let leftItem = UINavigationController.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightItem = UINavigationController.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        UINavigationController.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftItem, rightItem: rightItem)
        return controller
    }
    
    func getLoginViewController() {

        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                DispatchQueue.main.async {
                    self.setupDefaults()
                    //DataPeristence.shared.logout()
                    self.setLoginViewController()
                }
            } catch {
                print("Error")
                DispatchQueue.main.async {
                    self.setupDefaults()
                    self.setLoginViewController()
                }
                
            }
        }
    }
    
    
    func logoutButtonPressed() {
        getLoginViewController()
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}



