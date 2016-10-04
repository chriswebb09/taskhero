//
//  LoginViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    let store = DataStore.sharedInstance
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        view.addSubview(loginView)
        
        loginView.layoutSubviews()
        loginView.loginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        loginView.newUserButton.addTarget(self, action: #selector(signUpNewUserTapped), for: .touchUpInside)
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        spinner.centered(inView:view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }
    
    func didTapSignIn() {
        // Sign In with credentials.
        spinner.startAnimating()
        guard let email = loginView.usernameTextField.text, let password = loginView.passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    
                    let tabBar = TabBarController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tabBar
                }
                
            }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func signUpNewUserTapped() {
        let signUpVC = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: false)
    }
    
    
    
}
