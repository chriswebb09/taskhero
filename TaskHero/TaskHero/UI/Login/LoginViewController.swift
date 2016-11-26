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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === loginView.emailField) ? loginView.passwordField : loginView.emailField
        nextField.becomeFirstResponder()
        return true
    }
    
    func handleLogin() {
        checkForValidEmailInput()
        view.endEditing(true)
        loadingView.showActivityIndicator(viewController: self)
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
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
            self.loadingView.hideActivityIndicator(viewController: self)
            guard let userID = user?.uid else { return }
            self.store.currentUserString = userID
            self.store.fetchData()
            let tabBar = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBar
        })
    }
    
    func checkForValidEmailInput() {
        if loginView.emailField.text == nil || (self.loginView.emailField.text?.characters.count)! < 5 {
            UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0,
                           animations: {
                            self.loginView.emailField.layer.borderWidth = 2
                            self.loginView.emailField.layer.borderColor = UIColor.errorColor().cgColor
            }, completion: { _ in
                //self.loginView.emailField.textColor = UIColor.lightGray
                self.loginView.emailField.layer.borderColor = Constants.signupFieldColor
                self.loginView.emailField.layer.borderWidth = 1
            })
        }
    }
}

extension LoginViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func operationConfigure(operationQueue: OperationQueue, operation: Operation) {
        operationQueue.addOperation(operation)
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = .userInitiated
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        textField.layer.borderColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
    }
    
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
