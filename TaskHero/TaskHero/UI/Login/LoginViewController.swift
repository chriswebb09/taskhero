//
//  LoginViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let loginView = LoginView()
   
    let manager = AppManager.sharedInstance
    let store = DataStore.sharedInstance
    let loadingView = LoadingView()
    
    // MARK: Initialization Methods
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        edgesForExtendedLayout = []
        setupLogin()
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.gray, height: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.store.firebaseAPI.fetchValidUsernames()
    }
}

// Kicks off by checking emailfield has valid input / send editing and shows activity indicator on loading pop over / returns if conditions are not met.
// Attempts to signin using userinput for email and password else returns and prints out error description
// If there is error - hide loading popover

extension LoginViewController {
    
    @objc func handleLogin() {
        checkForValidEmailInput()
        view.endEditing(true)
        loadingView.showActivityIndicator(viewController: self)
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                self.loadingView.hideActivityIndicator(viewController:self)
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        print("invalid email")
                    case .errorCodeEmailAlreadyInUse:
                        print("in use")
                    default:
                        print("Create User Error: \(error)") }
                }
                print(error ?? "error")
                return
            }
            
            // If authorized hides loading popover
            // Ensures firuser has valid uid - if not returns / if valid firuser uid sends it to datastore as current userstring
            // Fetches user profile data from firebase database and sets datastore current user to that profile data
            // If everthing i successful sets rootviewcontroller to tabbarcontroller
            
            self.loadingView.hideActivityIndicator(viewController: self)
            guard let userID = user?.uid else { return }
            self.store.currentUserString = userID
            self.store.firebaseAPI.setupRefs()
            self.store.firebaseAPI.fetchUser(completion: { user in
                self.store.currentUser = user
                self.manager.setUserData(user: user)
            })
            self.manager.setLoggedInKey(userState: true)
            self.manager.hasLoggedIn()
            self.setupTabBar()
        }
    }
    
   fileprivate func setupTabBar() {
        let tabBar = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    // Checks that text has been entered and exceeds five characters in length
    
    fileprivate func checkForValidEmailInput() {
        if loginView.emailField.text == nil || (self.loginView.emailField.text?.characters.count)! < 5 {
            textFieldAnimation()
        }
    }
    
    fileprivate func setupLogin() {
        loginView.layoutSubviews()
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
        loginView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.loginView.loginButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
    }
}

extension LoginViewController {
    
    // MARK: - Textfield delegate methods
    // =========================================================================
    
    // If email field selected cycles to password field / if password field cycles to emailfield.
    // Hides keyboard/ ends view editting
    // Sets textfield text color and border to selected color
    // On ending edit textfield border color are set to deselect color
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Still implementing

    @objc fileprivate func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            textField.textColor = Constants.Login.loginFieldEditColor
            textField.font = Constants.signupFieldFont
            textField.layer.borderColor = Constants.Login.loginFieldEditBorderColor
            textField.layer.borderWidth = 1.1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.textColor = UIColor.lightGray
        textField.layer.borderColor = Constants.Login.loginFieldEditBorderColor
        checkForValidEmailInput()
    }
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 3, initialSpringVelocity: 0.0,  options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.loginView.emailField.layer.borderWidth = 1.2
                self.loginView.emailField.font = UIFont(name: "HelveticaNeue" , size: 16)
                self.loginView.emailField.textColor =  Constants.Login.loginFieldEditColor
            } }, completion: { _ in
                let when = DispatchTime.now() + 0.32
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.loginView.emailField.layer.borderWidth = 1
                    self.loginView.emailField.font = Constants.signupFieldFont
                    self.loginView.emailField.textColor = UIColor.lightGray
                    self.loginView.emailField.layer.borderColor = Constants.Login.loginFieldEditBorderColor
                    self.loginView.emailField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
                }
                
        })
    }
}
