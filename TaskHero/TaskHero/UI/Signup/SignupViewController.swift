//
//  SignupViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class SignupViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    deinit {
        print("SignupViewController deallocated from memory.")
    }
    
    let store = UserDataStore.sharedInstance
    let signupView = SignupView()
    var emailInvalidated = false
    let CharacterLimit = 11
    let helpers = Helpers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        signupView.layoutSubviews()
        edgesForExtendedLayout = []
        setupSignupView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    fileprivate func setupSignupView() {
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.passwordField.delegate = self
        signupView.loginButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UITextfield Delegate Methods
    // Checks for character length (implemented for username length) if characters exceed allowed range, text field will no longer except new characters
    
    
    func signupLogic(email: String, password: String, username: String, loadingView: LoadingView) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                loadingView.hideActivityIndicator(viewController: self)
                print(error ?? "unable to get specific error")
                return
            }
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let newUser = self.helpers.createUser(uid: uid, username: username, email: email)
            self.helpers.setupUser(user: newUser)
            let tabBar = TabBarController()
            self.helpers.loadTabBar(tabBar:tabBar)
        }
    }
    
    func signupButtonTapped() {
        signupLogic(email:signupView.emailField.text!, password: signupView.passwordField.text!, username: signupView.usernameField.text!, loadingView: LoadingView())
    }
    
    // Checks text for valid email format and returns bool based on result
    
    func validateEmailInput(email:String, confirm:String) -> Bool {
        let emailLower = email.lowercased()
        let confirmLower = confirm.lowercased()
        if (email.isValidEmail()) && (emailLower == confirmLower) { return true } else { emailInvalidated = true; return false }
    }
    
    // Checks that text has more than five characters / animates UITextField to blue color if true.
    
    func checkTextField(_ textField: UITextField) {
        if (textField.text?.characters.count)! > 5 {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { textField.layer.borderColor = UIColor.blue.cgColor },
                           completion: nil)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
