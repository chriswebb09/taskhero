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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
//        self.loginView.logoImage.isHidden = true
//        self.loginView.loginButton.isHidden = false
//        self.loginView.loginLabel.isHidden = false
//        self.loginView.passwordLabel.isHidden = false
//        self.loginView.passwordTextField.isHidden = false
//        self.loginView.userNameLabel.isHidden = false
//        self.loginView.usernameTextField.isHidden = false
    }
    
    func didTapSignIn() {
        // Sign In with credentials.
        guard let email = loginView.usernameTextField.text, let password = loginView.passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    let tabBar = TabBarController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tabBar
                }
//                self.loginView.loginButton.isHidden = true
//                self.loginView.loginLabel.isHidden = true
//                self.loginView.passwordLabel.isHidden = true
//                self.loginView.passwordTextField.isHidden = true
//                self.loginView.userNameLabel.isHidden = true
//                self.loginView.usernameTextField.isHidden = true
//                self.loginView.logoImage.isHidden = false
//                
//                
//                self.loginView.logoImage.transform = CGAffineTransform(translationX: -300, y: 0)
//                
//                Animations().springWithDelay(duration: 0.9, delay: 0.45, animations: {
//                    self.loginView.logoImage.transform = CGAffineTransform(translationX: 0, y: 0)
//                })
                
//                let delayTime = DispatchTime.now() + .seconds(5)
                
//                DispatchQueue.main.asyncAfter(deadline: delayTime){
//                    let tabBar = TabBarController()
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = tabBar
//                }
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
