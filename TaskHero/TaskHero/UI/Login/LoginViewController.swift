//
//  LoginViewController.swift
//  TaskHero
//

import UIKit
import Firebase
import SnapKit

final class LoginViewController: UIViewController {
    
    /* LoginViewController is called after InitialViewController
     * InitialViewController should be deallocated from memory after LoginViewController loads
     * Contains form for logging in with email address and password and button to load SignupViewController
     * Subviews loaded in LoginView - LoginView contains all UI elements
     * Large method for firebase sign in should be refactored as soon as is practical */
    
    var defaults = UserDefaults.standard
    var loadingView = LoadingView()
    var loginView: LoginView = LoginView() 
       // loginView.loginButton.isEnabled
    
    
    var loginViewModel: LoginViewModel = LoginViewModel(username:"check", password:"testpass") {
        didSet {
            loginViewModel.username = loginView.emailField.text!
            loginViewModel.password = loginView.passwordField.text!
        }
    }
    
    // MARK: - ViewController Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LOGGED IN \(defaults.bool(forKey: "hasLoggedIn"))")
        
        view.addSubview(loginView)
        
        setupDelegates()
        edgesForExtendedLayout = []
        
        loginView.setupLogin(self)
        loginView.loginButton.isEnabled = false
        
        loginView.passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        loginView.loginButton.isEnabled = false
        
        if loginView.loginButton.isEnabled == false {
            loginView.loginButton.backgroundColor = .lightGray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    /* Adds UITextField delegates to self(LoginViewController) */
    
    func setupDelegates() {
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /* Selector method that Pushes SignupViewController on button tap */
    
    public func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
}

extension LoginViewController {
    
    // MARK: - Login Method Extension
    
    /* HandleLogin starts by initially checking emailfield for text input formatted as valid email address - if not method returns
     * then it sets LoginViewController.view endEditting property to true
     * next loadingView (property implmemented at top) calls showActivity indicator method which takes viewController parameter -
     * pass in self. Sets guard condition for email and password for emailfield.text and passwordfield.text - if not returns
     * calls firebase FIRAuth.auth.signIn method - which takes email and password
     * FIRAuth.auth.signIn returns FIRUser and FIRError objects, if error is not nil - hides loadingView.activity indicator enters
     * switch statement to return proper error message
     * sets guard condition for userID from user?.uid (FIRUser) / if not - returns
     */
    
    func handleLogin() {
        checkForValidEmailInput()
        view.endEditing(true)
        loadingView.showActivityIndicator(viewController: self)
        if let emailText = loginView.emailField.text {
            loginViewModel.username = emailText
        }
        FIRAuth.auth()?.signIn(withEmail: loginViewModel.username, password: loginViewModel.password) { [unowned self] user, error in
            if error != nil {
                self.loadingView.hideActivityIndicator(viewController:self)
                if let err = error, let errCode = FIRAuthErrorCode(rawValue: err._code) {
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
        UserDataStore.sharedInstance.firebaseAPI.fetchUserData { currentUser in
            UserDataStore.sharedInstance.currentUser = currentUser
        }
    }
    
    /* On global DispatchQueue with qos: userInituated sets self to unowned self
     * creates new DataStore.sharedInstance sets new DataStore instance currentUserString
     * property to userID sets up FirebaseAPI database reference handles calls new DataStore
     * FirebaseAPI property and uses fetchUser method sets new DataStore instance currentUser
     * property to user returned from fetchUser method call sets userDefaults proporties in AppManager
     * to logged in
     */
    
    func completeLogin() {
        DispatchQueue.global(qos: .background).async {
            self.fetchData()
            DispatchQueue.main.async {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "hasLoggedIn")
                defaults.synchronize()
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
    
    /* Checks that text has been entered and exceeds five characters in length */
    
    fileprivate func checkForValidEmailInput() {
        if loginView.emailField.text == nil || (self.loginView.emailField.text?.characters.count)! < 5 {
            loginView.textFieldAnimation()
        }
    }
    
    // MARK: - Textfield delegate methods
    
    /* If email field selected cycles to password field / if password field cycles to emailfield.
     * Hides keyboard/ ends view editting
     * Sets textfield text color and border to selected color
     * On ending edit textfield border color are set to deselect color
     * On return key press */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField == loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let emailText = loginView.emailField.text, let passwordText = loginView.passwordField.text {
            
            if (emailText.characters.count > 4) && (passwordText.characters.count >= 6) {
                loginView.loginButton.backgroundColor = Constants.Color.buttonColor.setColor
                //buttonColor
                loginView.loginButton.isEnabled = true
            }
        }
    }
    
    /* On beginning editting changes textfield UI properties */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = Constants.Color.backgroundColor.setColor
        textField.font = Constants.signupFieldFont
        textField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
        textField.layer.borderWidth = 1.1
        
        textInputAnimation()
        self.loginView.editState = true
    }
    
    func textInputAnimation() {
        view.layoutIfNeeded()
        self.loginView.layoutIfNeeded()
        if loginView.editState != true {
            UIView.animate(withDuration: 0.3) {
                self.loginView.constraintsForInput()
              //  self.loginView.layoutIfNeeded()
                self.view.layoutIfNeeded()
                
            }
        }
    }
    
    func constraintsForInput() {
        self.loginView.logoImageView.snp.makeConstraints { make in
            make.height.equalTo(loginView.snp.height).multipliedBy(0.02)
            make.width.equalTo(loginView.snp.width).multipliedBy(0.5)
            make.top.equalTo(loginView.snp.top).offset(self.loginView.bounds.height * 0.05)
        }
        self.loginView.emailField.snp.makeConstraints { make in
            make.top.equalTo(self.loginView.logoImageView.snp.bottom).offset(self.loginView.bounds.height * 0.06)
        }
        self.loginView.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.loginView.passwordField.snp.bottom).offset(self.loginView.bounds.height * 0.04)
        }
    }
    
    
    /* When no longer using input fields changes textfield ui properties back to original */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.textColor = .lightGray
        textField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
        
        checkForValidEmailInput()
    }
}
