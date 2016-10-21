//
//  SplashViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    //var initialView = InitialView()
    
    var loginVC = LoginViewController()
    
    var initialView: LoginView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        //loginLabel.center.y -= view.bounds.width
        //self.initialView.emailField.center.x -= view.bounds.width
        //self.initialView.passwordField.center.x += view.bounds.width
        
        view.addSubview(initialView)
        initialView.layoutSubviews()
    }
    
    
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        initialView = loginVC.loginView
        super.init(coder: coder)!
        
        // …
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.initialView.logoImageView.alpha = 0
        
        self.initialView.emailField.alpha = 0
        self.initialView.passwordField.alpha = 0
        self.initialView.loginButton.alpha = 0
        self.initialView.registerLabel.alpha = 0
        self.initialView.viewDivider.alpha = 0
        self.initialView.signupButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.initialView.logoImageView.center.y -= 80
        UIView.animate(withDuration: 1, delay: 0.05,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 2,
                       options: [.beginFromCurrentState, .curveEaseInOut], animations: {
                        self.initialView.logoImageView.center.y += 78
                        // self.initialView.logoImageView.center.y += 0
                        
                        
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.9,
                       options: [.beginFromCurrentState, .curveEaseOut], animations: {
                        self.initialView.logoImageView.alpha = 1
                        self.initialView.emailField.alpha = 1
                        self.initialView.passwordField.alpha = 1
                        self.initialView.loginButton.alpha = 1
                        self.initialView.registerLabel.alpha = 1
                        self.initialView.viewDivider.alpha = 1
                        self.initialView.signupButton.alpha = 1
                        
                        self.navigationController?.navigationBar.isHidden = false
                        self.navigationController?.navigationBar.barTintColor = Constants.navbarBarTintColor
                        
                        
                        //self.initialView.logoImageView.center.y += 48
                        // self.initialView.logoImageView.center.y += 0
                        
                        
            }, completion: nil)
        
    }
    
    
    
}


extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}

