//
//  SplashViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    
    var loginVC = LoginViewController()
    var initialView: LoginView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(initialView)
        initialView.layoutSubviews()
    }
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        initialView = loginVC.loginView
        super.init(coder: coder)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        initialView.emailField.alpha = 0
        initialView.passwordField.alpha = 0
        initialView.loginButton.alpha = 0
        initialView.registerLabel.alpha = 0
        initialView.viewDivider.alpha = 0
        initialView.signupButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        UIView.animate(withDuration: 2, delay: 0.06, usingSpringWithDamping: 4, initialSpringVelocity: 1, options: [.beginFromCurrentState, .curveEaseInOut, .autoreverse], animations: {
            self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width * 1.1, height: self.initialView.logoImageView.frame.height * 1.1) }, completion: { _ in
                self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width, height: self.initialView.logoImageView.frame.height) })
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: [.beginFromCurrentState, .curveEaseOut],animations: {
            self.initialView.logoImageView.alpha = 1
            self.initialView.emailField.alpha = 1
            self.initialView.passwordField.alpha = 1
            self.initialView.loginButton.alpha = 1
            self.initialView.registerLabel.alpha = 1
            self.initialView.viewDivider.alpha = 1
            self.initialView.signupButton.alpha = 1
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.barTintColor = Constants.Tabbar.navbarBarTintColor
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

