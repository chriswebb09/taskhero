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
        view.backgroundColor = UIColor.white
        initView.layoutSubviews()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initView.zoomAnimation({ })
    }
    
    func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: false)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
}
