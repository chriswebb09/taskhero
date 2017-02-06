//
//  AppScreen.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AppScreenViewController: UIViewController {
    
    let appScreenView = AppScreenView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appScreenView)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        appScreenView.layoutSubviews()
        appScreenView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        appScreenView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = true
    }
    
    func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: false)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
}
