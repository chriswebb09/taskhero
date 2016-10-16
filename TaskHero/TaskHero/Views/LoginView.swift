//
//  LoginView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo3")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var emailField: LeftPaddedTextField = {
        let emailField = LeftPaddedTextField()
        emailField.placeholder = "Enter email"
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.borderWidth = 1
        emailField.layer.cornerRadius = 2
        emailField.keyboardType = .emailAddress
        return emailField
    }()
    
    lazy var passwordField: LeftPaddedTextField = {
        let passwordField = LeftPaddedTextField()
        passwordField.placeholder = "Enter password"
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 2
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.font, size: 20)
        button.layer.cornerRadius = 2
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Not a member yet?", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    func setupConstraints() {
        
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.logoImageWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.logoImageHeight).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -210).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80).isActive = true
        
        addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.centerYAnchor.constraint(equalTo: centerYAnchor, constant:30).isActive = true
        passwordField.isSecureTextEntry = true
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 140).isActive = true
        
        addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor, multiplier:Constants.loginButtonWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 210).isActive = true
    }
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
