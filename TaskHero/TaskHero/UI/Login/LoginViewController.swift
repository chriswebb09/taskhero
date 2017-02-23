//
//  LoginViewController.swift
//  TaskHero
//

import UIKit
import Firebase
import SnapKit

final class LoginViewController: UIViewController {
    
    /*
     LoginViewController is called after InitialViewController
     InitialViewController should be deallocated from memory after LoginViewController loads
     Contains form for logging in with email address and password and button to load SignupViewController
     Subviews loaded in LoginView - LoginView contains all UI elements
     Large method for firebase sign in should be refactored as soon as is practical
     */
    
    var defaults = UserDefaults.standard
    var loadingView = LoadingView()
    var loginView: LoginView = LoginView()
    
    var loginViewModel: LoginViewModel = LoginViewModel(username:"check", password:"testpass") {
        willSet {
            print("New viewModel value \(newValue)")
        }
        
        didSet {
            loginView.loginButton.isEnabled = loginViewModel.isValid
            loginView.loginButton.backgroundColor = loginViewModel.enableColor
            loginViewModel.username = loginView.emailField.text!
            loginViewModel.password = loginView.passwordField.text!
            print(loginView.emailField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // logvi
        loginViewModel.setupUI(controller: self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
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
    
    // MARK: - Login Method Extension
    
    /*
     HandleLogin starts by initially checking emailfield for text input formatted as valid email address - if not method returns
     then it sets LoginViewController.view endEditting property to true
     next loadingView (property implmemented at top) calls showActivity indicator method which takes viewController parameter -
     pass in self. Sets guard condition for email and password for emailfield.text and passwordfield.text - if not returns
     calls firebase FIRAuth.auth.signIn method - which takes email and password
     FIRAuth.auth.signIn returns FIRUser and FIRError objects, if error is not nil - hides loadingView.activity indicator enters
     switch statement to return proper error message
     sets guard condition for userID from user?.uid (FIRUser) / if not - returns
     */
    
    func handleLogin() {
        if loginViewModel.isValid {
            dismissKeyboard()
            loadingView.showActivityIndicator(viewController: self)
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
        } else {
            return
        }
      
    }
    
    func fetchData() {
        UserDataStore.sharedInstance.firebaseAPI.fetchUserData { currentUser in
            UserDataStore.sharedInstance.currentUser = currentUser
        }
    }
    
    /*
     On global DispatchQueue with qos: userInituated sets self to unowned self
     creates new DataStore.sharedInstance sets new DataStore instance currentUserString
     property to userID sets up FirebaseAPI database reference handles calls new DataStore
     FirebaseAPI property and uses fetchUser method sets new DataStore instance currentUser
     property to user returned from fetchUser method call sets userDefaults proporties in AppManager
     to logged in
     */
    
    func completeLogin() {
        DispatchQueue.global(qos: .background).async {
            self.fetchData()
            DispatchQueue.main.async {
                SharedMethods.loginDefaults()
                self.loadingView.hideActivityIndicator(viewController: self)
                SharedMethods.loadTabBar(tabBar: TabBarController())
            }
        }
    }
    
    /* Checks that text has been entered and exceeds five characters in length */
    
    // MARK: - Textfield delegate methods
    
    /*
     If email field selected cycles to password field / if password field cycles to emailfield.
     Hides keyboard/ ends view editting
     Sets textfield text color and border to selected color
     On ending edit textfield border color are set to deselect color
     On return key press
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField == loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let emailText = loginView.emailField.text, let passwordText = loginView.passwordField.text {
            loginViewModel.username = emailText
            loginViewModel.password = passwordText
            print("ENABLED \(loginViewModel.isValid)")
        }
    }
    
   
    
    /* On beginning editting changes textfield UI properties */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = Constants.Color.backgroundColor.setColor
        textField.font = Constants.signupFieldFont
        textField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
        textField.layer.borderWidth = 1.1
        
        textInputAnimation()
        loginView.editState = true
    }
    
    func textInputAnimation() {
        loginView.constraintsForInput()
        if loginView.editState != true {
            UIView.animate(withDuration: 0.3) {
                self.loginView.layoutIfNeeded()
            }
        }
    }
    
    /*
     When no longer using input fields
     textfield properties change back to original
     */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.textColor = .lightGray
        textField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
        loginViewModel.checkForValidEmailInput(loginView: loginView)
    }
}
