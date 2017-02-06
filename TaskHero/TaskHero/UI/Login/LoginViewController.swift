//
//  LoginViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class LoginViewController: UIViewController {
    
    /*
     - LoginViewController is called after InitialViewController
     - InitialViewController should be deallocated from memory after LoginViewController loads
     - Contains form for logging in with email address and password and button to load SignupViewController
     - Subviews loaded in LoginView - LoginView contains all UI elements
     - Large method for firebase sign in should be refactored as soon as is practical
     */
    
    // MARK: - Deallocation from memory
    
    deinit {
        print("LoginViewController deallocated from memory")
    }
    
    let store = UserDataStore.sharedInstance  /* Singleton for the instance of the the authenticated user that shared by the entire application */
    var loadingView = LoadingView()  /* Activity indicator and background container view instantiated - will be added to view on login button press */
    var loginView: LoginView = LoginView()
    var loginViewModel: LoginViewModel = LoginViewModel(username:"check", password:"testpass") {
        didSet {
            loginViewModel.username = loginView.emailField.text!
            loginViewModel.password = loginView.passwordField.text!
        }
    }
    
    // MARK: - ViewController Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        setupDelegates()
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
        loginView.setupLogin(self)
        loginView.loginButton.isEnabled = false
        loginView.passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.gray, height: 1.0)
        loginView.loginButton.isEnabled = false
        if loginView.loginButton.isEnabled == false {
            loginView.loginButton.backgroundColor = UIColor.lightGray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    // Adds UITextField delegates to self(LoginViewController)
    
    func setupDelegates() {
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
        loginView.emailField.text = Secrets.email
        loginView.passwordField.text = Secrets.password
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // selector method that Pushes SignupViewController on button tap
    
    public func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    // MARK: - Login Method Extension
    
    /*
     - handleLogin starts by initially checking emailfield for text input formatted as valid email address - if not method returns
     - then it sets LoginViewController.view endEditting property to true
     - next loadingView (property implmemented at top) calls showActivity indicator method which takes viewController parameter -
     pass in self.
     - sets guard condition for email and password for emailfield.text and passwordfield.text - if not returns
     - calls firebase FIRAuth.auth.signIn method - which takes email and password
     - FIRAuth.auth.signIn returns FIRUser and FIRError objects, if error is not nil - hides loadingView.activity indicator enters
     switch statement to return proper error message
     - sets guard condition for userID from user?.uid (FIRUser) / if not - returns
     */
    
    func handleLogin() {
        checkForValidEmailInput()
        view.endEditing(true)
        loadingView.showActivityIndicator(viewController: self)
        loginViewModel.username = loginView.emailField.text!
        FIRAuth.auth()?.signIn(withEmail: loginViewModel.username, password: loginViewModel.password) { [unowned self] user, error in
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
            self.completeLogin()
        }
    }
    
    
    func fetchData() {
        UserDataStore.sharedInstance.firebaseAPI.fetchUserData { currentUser in UserDataStore.sharedInstance.currentUser = currentUser }
        UserDataStore.sharedInstance.setLoggedInKey(userState: true)
        UserDataStore.sharedInstance.hasLoggedIn()
    }
    
    /*
     - On global DispatchQueue with qos: userInituated sets self to unowned self
     * creates new DataStore.sharedInstance
     * sets new DataStore instance currentUserString property to userID
     * sets up FirebaseAPI database reference handles
     * calls new DataStore FirebaseAPI property and uses fetchUser method
     * sets new DataStore instance currentUser property to user returned from fetchUser method call
     * sets userDefaults proporties in AppManager to logged in
     */
    
    func completeLogin() {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            self.fetchData()
            /*  - On main thread hides loadingView.activity indicator and sets appDelegate window to tabbarcontroller */
            DispatchQueue.main.async { [unowned self] in
                self.loadingView.hideActivityIndicator(viewController: self)
                self.setupTabBar()
            }
        }
    }
    
    // MARK: - Load TabbarController
    
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
    
    // MARK: - Textfield delegate methods
    
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
    
    
    func textFieldDidChange(_ textField: UITextField) {
        if (loginView.emailField.text?.characters.count)! > 4 && (loginView.passwordField.text?.characters.count)! >= 6 {
            loginView.loginButton.backgroundColor = Constants.Color.buttonColor
            loginView.loginButton.isEnabled = true
        }
    }
    
    
    // On beginning editting changes textfield UI properties
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = Constants.Color.backgroundColor
        textField.font = Constants.signupFieldFont
        textField.layer.borderColor = Constants.Color.backgroundColor.cgColor
        textField.layer.borderWidth = 1.1
    }
    
    // When no longer using input fields changes textfield ui properties back to original
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.textColor = UIColor.lightGray
        textField.layer.borderColor = Constants.Color.backgroundColor.cgColor
        checkForValidEmailInput()
        if (loginView.emailField.text?.characters.count)! > 4 && (loginView.passwordField.text?.characters.count)! >= 6 {
            loginView.loginButton.isEnabled = true
        }
    }
}
