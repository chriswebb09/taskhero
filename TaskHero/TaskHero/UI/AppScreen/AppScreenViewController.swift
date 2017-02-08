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
        appScreenView.layoutSubviews()
        appScreenView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        appScreenView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func loginButtonTapped() {
        navigationController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
