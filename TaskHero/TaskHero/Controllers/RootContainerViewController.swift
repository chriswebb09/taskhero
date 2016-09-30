//
//  RootViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
//import SplashScreenUI
//import Commons

class RootContainerViewController: UIViewController {
    
    fileprivate var rootViewController = UIViewController()
    
    let initialView = InitialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(initialView)
        initialView.layoutSubviews()
        showSplashViewController()
    }
    
    func showSplashViewControllerNoPing() {
//        if rootViewController is SplashViewController {
//            return
//        }
//
//        let splashViewController = SplashViewController()
//        
//        rootViewController = splashViewController
        
       // view.addSubview(splashViewController.view)
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //appDelegate.window?.rootViewController = splashViewController
        
        
        
        
        
        //        if rootViewController is SplashViewController {
        //            return
        //        }
        //
        //        rootViewController?.willMove(toParentViewController: nil)
        //        rootViewController?.removeFromParentViewController()
        //        rootViewController?.view.removeFromSuperview()
        //        rootViewController?.didMove(toParentViewController: nil)
        //
        //        let splashViewController = SplashViewController(tileViewFileName: "Chimes")
        //        rootViewController = splashViewController
        //        splashViewController.pulsing = true
        //
        //        splashViewController.willMove(toParentViewController: self)
        //        addChildViewController(splashViewController)
        //        view.addSubview(splashViewController.view)
        //        splashViewController.didMove(toParentViewController: self)
        
    }
    
    /// Simulates an API handshake success and transitions to MapViewController
    func showSplashViewController() {
        //showSplashViewControllerNoPing()
        
        delay(6.00) {
            self.showLoginViewController()
        }
    }
    
    
    
    
    func showLoginViewController() {
        
        
        guard !(rootViewController is LoginViewController) else { return }
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let loginVC = LoginViewController()
        
        appDelegate.window?.rootViewController = loginVC
        
//        if let rootViewController = self.rootViewController {
//            transition(from: rootViewController, to: loginVC, duration: 0.55, options: [.transitionCrossDissolve, .curveEaseOut], animations: { () -> Void in
//                
//                }, completion: { _ in
//                    appDelegate.window?.rootViewController = loginVC
//            })
//        } else {
//            
//        }
        
        //loginVC.willMove(toParentViewController: self)
        //addChildViewController(loginVC)
        
       // if let rootViewController = self.rootViewController {
            
            //rootViewController.willMove(toParentViewController: nil)
            
        
        
    
//    } else {
//            rootViewController = loginVC
//            view.addSubview(loginVC.view)
//            loginVC.didMove(toParentViewController: self)
//            appDelegate.window?.rootViewController = loginVC
//        }
    }
    
    
    
    
   // override var prefersStatusBarHidden : Bool {
//        switch rootViewController  {
//        case is SplashViewController:
//            return true
//        case is LoginViewController:
//            return false
//        default:
//            return false
//        }
//    }
    
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

