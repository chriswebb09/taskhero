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
    
    var initialView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        //loginLabel.center.y -= view.bounds.width
        self.initialView.emailField.center.x -= view.bounds.width
        self.initialView.passwordField.center.x += view.bounds.width
        
        view.addSubview(initialView)
        initialView.layoutSubviews()
        initialView.emailField.isHidden = true
        initialView.loginButton.isHidden = true
        initialView.passwordField.isHidden = true
        initialView.registerLabel.isHidden = true
        initialView.viewDivider.isHidden = true
        initialView.signupButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.initialView.logoImageView.alpha = 0
        //self.initialView.logoImageView.center.x -= view.bounds.width
        //self.initialView.emailField.center.x -= self.view.bounds.width
        //self.initialView.passwordField.center.x += self.view.bounds.width
        
        //logoLabel.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        UIView.animate(withDuration: 1, delay: 0.1,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.initialView.logoImageView.alpha = 1
                        //self.initialView.emailField.center.x += self.view.bounds.width
                        //self.initialView.passwordField.center.x -= self.view.bounds.width
            }, completion: nil)
    }
    
    
}
