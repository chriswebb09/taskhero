//
//  LoginViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let loginView = LoginView()
    
    let store = DataStore.sharedInstance
    let schema = Database.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.layoutSubviews()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
        loginView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    func handleLogin() {
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {
            
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            
            //login sucessful
            self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
            
            self.schema.fetchUser(completion: { (user) in
                print(user)
            })
            
            let tabBar = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBar
        })
        
    }
    
}
