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
    
    let store = DataStore.sharedInstance
    
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.layoutSubviews()
        loginView.loginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        loginView.newUserButton.addTarget(self, action: #selector(signUpNewUserTapped), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapSignIn() {
        // Sign In with credentials.
        guard let email = loginView.usernameTextField.text, let password = loginView.passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let tabBar = TabBarController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBar
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
