//
//  RootViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit



class RootContainerViewController: UIViewController {
    
    fileprivate var rootViewController = UIViewController()
    
    let initialView = InitialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplashViewController()
    }

    
    func showSplashViewController() {
        
        rootViewController.willMove(toParentViewController: nil)
        rootViewController.removeFromParentViewController()
        rootViewController.view.removeFromSuperview()
        rootViewController.didMove(toParentViewController: nil)
        
        let splashViewController = SplashViewController()
        
        rootViewController = splashViewController
        splashViewController.willMove(toParentViewController: self)
        addChildViewController(splashViewController)
        view.addSubview(splashViewController.view)
        splashViewController.didMove(toParentViewController: self)
        
        delay(6.00) {
            self.showLoginViewController()
        }
    }
    
    func showLoginViewController() {
        guard !(rootViewController is LoginViewController) else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginVC = LoginViewController()
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:loginVC)
    }
    
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

