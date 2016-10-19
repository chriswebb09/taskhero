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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        textField.layer.borderColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func handleLogin() {
        showActivityIndicatory(mainView:view)
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {
            
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            
            
            self.activityIndicator.stopAnimating()
            self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
            
            self.schema.fetchUser(completion: { (user) in
                print(user)
            })
            
            let tabBar = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBar
        })
    }
    
    
    func showActivityIndicatory(mainView: UIView) {
        
        let containerView: UIView = UIView()
        
        containerView.frame = mainView.frame
        containerView.center = mainView.center
        containerView.backgroundColor = UIColor.clear
        
        let loadingView: UIView = UIView()
        
        loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
        loadingView.center = mainView.center
        loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2,
                                           y:loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        containerView.addSubview(loadingView)
        mainView.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    
    
}
