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
    
    
    fileprivate let loginView = LoginView() /* LoginView instantiated - will be added to viewcontroller view in viewdidload */
    
    let manager = AppManager.sharedInstance /* User defaults data methods */
    
    let store = DataStore.sharedInstance
    
    fileprivate let loadingView = LoadingView() /* Activity indicator and background container view instantiated -
     will be added to view on login button press */
    
    // ================================
    // MARK: Initialization Methods
    // ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        edgesForExtendedLayout = []
        loginView.setupLogin(viewController:self)
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
                        print("Invalid Email For Sign In")
                    default:
                        print("User Authentication Error: \(error)") }
                }
                print(error ?? "Unknown error occured when attempting sign in authentication")
                return
            }
            
            // If authorized hides loading popover
            // Ensures firuser has valid uid - if not returns / if valid firuser uid sends it to datastore as current userstring
            // Fetches user profile data from firebase database and sets datastore current user to that profile data
            // If everthing i successful sets rootviewcontroller to tabbarcontroller
            
            self.loadingView.hideActivityIndicator(viewController: self)
            guard let userID = user?.uid else { return }
            /* Fetching user profile data and setting dataStore current user property to that profile data */
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                let newStore = DataStore.sharedInstance
                newStore.currentUserString = userID
                newStore.firebaseAPI.setupRefs()
                newStore.firebaseAPI.fetchUser { currentUser in newStore.currentUser = currentUser }
                /* setting user defaults for logged in */
                self.manager.setLoggedInKey(userState: true)
                self.manager.hasLoggedIn()
                /* calls setupTabBar on main thread to load tabbarcontroller */
                DispatchQueue.main.async {
                    self.setupTabBar()
                }
            }
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
            loginView.textFieldAnimation()
        }
    }
}

extension LoginViewController {
    
    // ======================================
    // MARK: - Textfield delegate methods
    // ======================================
    
    // If email field selected cycles to password field / if password field cycles to emailfield.
    // Hides keyboard/ ends view editting
    // Sets textfield text color and border to selected color
    // On ending edit textfield border color are set to deselect color
    
    // On return key press
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // selector method that Pushes SignupViewController on button tap
    @objc public func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async { [unowned textField] in
            textField.textColor = Constants.Color.backgroundColor
            textField.font = Constants.signupFieldFont
            textField.layer.borderColor = Constants.Color.backgroundColor.cgColor
            textField.layer.borderWidth = 1.1
        }
    }
    
    // When no longer using input fields
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DispatchQueue.main.async { [unowned textField] in
            textField.layer.borderWidth = 1
            textField.textColor = UIColor.lightGray
            textField.layer.borderColor = Constants.Color.backgroundColor.cgColor
            self.checkForValidEmailInput()
        }
    }
}
