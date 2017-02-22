//
//  LoginViewModel.swift
//  TaskHero
//

import UIKit

struct LoginViewModel {
    
    var username: String {
        willSet {
            print("About to set username to:  \(newValue)")
        }
        didSet {
            if username != oldValue {
                getUserName(textFieldText: username)
            }
        }
    }
    
    var password: String {
        willSet {
            print("About to set password to:  \(newValue)")
        }
        didSet {
            if password != oldValue {
                getUserName(textFieldText: password)
            }
        }
    }
    
    func getUserName(textFieldText: String) {
        print("getting user credentials\(textFieldText)")
    }
    
    var isValid: Bool {
        if username.characters.count > 4 && password.characters.count > 8 {
            return true
        } else {
            return false
        }
    }
    
    var enableColor: UIColor {
        if isValid == true {
            return .blue
        } else {
            return .lightGray
        }
    }
    
    func setupTabBar() {
        let tabBar = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    
   func checkForValidEmailInput(loginView: LoginView) {
        if loginView.emailField.text == nil || (loginView.emailField.text?.characters.count)! < 5 {
            loginView.textFieldAnimation()
        }
    }
    
    func setupUI(controller: LoginViewController) {
        controller.view.addSubview(controller.loginView)
        controller.setupDelegates()
        controller.edgesForExtendedLayout = []
        controller.loginView.setupLogin(controller)
        controller.loginView.loginButton.isEnabled = false
        controller.loginView.passwordField.addTarget(self, action: #selector(controller.textFieldDidChange(_:)), for: .editingChanged)
        let buttonColor: UIColor = controller.loginView.loginButton.isEnabled ? .lightGray : enableColor
        controller.loginView.loginButton.backgroundColor = buttonColor
    }
    
}

