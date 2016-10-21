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
        // self.initialView.logoImageView.alpha = 0
        //self.initialView.logoImageView.bounds.width =
        self.initialView.emailField.alpha = 0
        self.initialView.passwordField.alpha = 0
        self.initialView.loginButton.alpha = 0
        self.initialView.registerLabel.alpha = 0
        self.initialView.viewDivider.alpha = 0
        self.initialView.signupButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        //self.initialView.logoImageView.center.y -= 80
        UIView.animate(withDuration: 2, delay: 0.06,
                       usingSpringWithDamping: 4,
                       initialSpringVelocity: 1,
                       options: [.beginFromCurrentState, .curveEaseInOut, .autoreverse], animations: {
                        //self.initialView.logoImageView.center.y += 78
                        self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width * 1.1, height: self.initialView.logoImageView.frame.height * 1.1)
                        // self.initialView.logoImageView.center.y += 0
            }, completion: { _ in
                self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width, height: self.initialView.logoImageView.frame.height)
                //self.initialView.logoImageView.frame.width
        })
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
    // UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
    // animations: {
    // self.loginView.emailField.layer.borderWidth = 2
    //  self.loginView.emailField.layer.borderColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0).cgColor
    //  }, completion: { _ in
    //   self.loginView.emailField.layer.borderColor = Constants.signupFieldColor
    //   self.loginView.emailField.layer.borderWidth = 1
    //   })
}

extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}

