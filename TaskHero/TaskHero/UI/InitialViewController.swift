//
//  InitialViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/26/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    let initView = InitView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(initView)
        initView.layoutSubviews()
        initView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        initView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: false)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
}
