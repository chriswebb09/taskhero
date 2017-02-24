//
//  LoginViewModel.swift
//  TaskHero
//

import UIKit

protocol LoginViewModelProtocol: class {
    var username: String { get set }
    var password: String { get set }
    //var isValid: String { get }
    var enableColor: UIColor { get }
    func getUserName(textFieldText: String)
    
    func checkForValidEmailInput(loginView: LoginView)
    
    func setupUI(controller: LoginViewController)
}

class LoginViewModel: LoginViewModelProtocol {
    
    var username: String = "" {
        willSet {
            print("About to set username to:  \(newValue)")
        }
        didSet {
            if username != oldValue {
                getUserName(textFieldText: username)
            }
        }
    }
    
    var password: String = "" {
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
        if username.characters.count >= 4 && password.characters.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    var enableColor: UIColor {
        if isValid == true {
            return .button
        } else {
            return .lightGray
        }
    }
    
    //   convenience init() {
    //
    //    }
    //
    func checkForValidEmailInput(loginView: LoginView) {
        if loginView.emailField.text == nil || (loginView.emailField.text?.characters.count)! < 5 {
            loginView.textFieldAnimation()
        }
    }
    
    func setupUI(controller: LoginViewController) {
        controller.view.addSubview(controller.loginView)
        controller.loginView.setupLogin(controller)
        controller.loginView.passwordField.addTarget(self, action: #selector(controller.textFieldDidChange(_:)), for: .editingChanged)
        controller.loginView.loginButton.addTarget(controller, action: #selector(controller.handleLogin), for: .touchUpInside)
        controller.loginView.emailField.delegate = controller
        controller.loginView.passwordField.delegate = controller
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: controller, action: #selector(controller.dismissKeyboard))
        controller.view.addGestureRecognizer(tap)
    }
    
}

