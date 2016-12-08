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
    let loadingView = LoadingView()
    
    
    // MARK: Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        edgesForExtendedLayout = []
        
        loginView.layoutSubviews()
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
        loginView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        
        let operationQueue = OperationQueue()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        let operation = BlockOperation(block: { () -> Void in
            self.loginView.loginButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
        })
        operationConfigure(operationQueue: operationQueue, operation: operation)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        navigationController?.navigationBar.setBottomBorderColor(color: UIColor.gray, height: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        store.fetchValidUsernames()
    }
}

// Kicks off by checking emailfiel has valid input / send editing and shows activity indicator on loading pop over / returns if conditions are not met.

extension LoginViewController {
    
    func handleLogin() {
        checkForValidEmailInput()
        view.endEditing(true)
        loadingView.showActivityIndicator(viewController: self)
        
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {
            return
        }
        
        // Attempts to signin using userinput for email and password else returns and prints out error description
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                
                // if there is error - hide loading popover
                
                self.loadingView.hideActivityIndicator(viewController:self)
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        print("invalid email")
                    case .errorCodeEmailAlreadyInUse:
                        print("in use")
                    default:
                        print("Create User Error: \(error)")
                    }
                }
                print(error ?? "error")
                return
            }
            
            // If authorized hides loading popover
            
            self.loadingView.hideActivityIndicator(viewController: self)
            
            // Ensures firuser has valid uid - if not returns / if valid firuser uid sends it to datastore as current userstring
            
            guard let userID = user?.uid else { return }
            self.store.currentUserString = userID
            
            // Fetches user profile data from firebase database and sets datastore current user to that profile data
            
            self.store.fetchUser(completion: { user in
                self.store.currentUser = user
            })
            
            // If everthing i successful sets rootviewcontroller to tabbarcontroller
            
            let tabBar = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBar
        })
        
    }
    
    // Checks that text has been entered and exceeds five characters in length
    
    fileprivate func checkForValidEmailInput() {
        
        if loginView.emailField.text == nil || (self.loginView.emailField.text?.characters.count)! < 5 {
            
            UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
                           animations: {
                            
                            self.loginView.emailField.layer.borderWidth = 2
                            self.loginView.emailField.layer.borderColor = UIColor.errorColor().cgColor
            }, completion: { _ in
                
                self.loginView.emailField.layer.borderColor = Constants.signupFieldColor
                self.loginView.emailField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
            })
        }
    }
}

extension LoginViewController {
    
    // If email field selected cycles to password field / if password field cycles to emailfield.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextField = (textField === loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    // Hides keyboard/ ends view editting
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Still implementing
    
    func operationConfigure(operationQueue: OperationQueue, operation: Operation) {
        
        operationQueue.addOperation(operation)
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = .userInitiated
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    // Sets textfield text color and border to selected color
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = Constants.Login.loginFieldEditColor
        textField.layer.borderColor = Constants.Login.loginFieldEditBorderColor
    }
    
    // On ending edit textfield border color are set to deselect color
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = UIColor.lightGray
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}
