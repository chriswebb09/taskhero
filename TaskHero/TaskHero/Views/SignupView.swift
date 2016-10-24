//
//  SignupView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SignupView: UIView {
    
    lazy var signupViewLabel: UILabel = {
        let signupViewLabel = UILabel()
        signupViewLabel.textColor = UIColor.black
        signupViewLabel.text = "Become a Member"
        signupViewLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        signupViewLabel.textAlignment = .center
        return signupViewLabel
    }()
    
    lazy var usernameField: TextFieldExtension = {
        let usernameField = TextFieldExtension()
        usernameField.placeholder = "Choose your username"
        usernameField.font = Constants.signupFieldFont
        usernameField.layer.borderColor = Constants.signupFieldColor
        usernameField.layer.borderWidth = 1
        usernameField.keyboardType = .emailAddress
        return usernameField
    }()
    
    lazy var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension()
        emailField.placeholder = "Enter email"
        emailField.font = Constants.signupFieldFont
        emailField.layer.borderColor = Constants.signupFieldColor
        emailField.layer.borderWidth = 1
        emailField.keyboardType = .emailAddress
        return emailField
    }()
    
    lazy var confirmEmailField: TextFieldExtension = {
        let confirmEmailField = TextFieldExtension()
        confirmEmailField.placeholder = "Confirm your email address"
        confirmEmailField.font = Constants.signupFieldFont
        confirmEmailField.layer.borderColor = Constants.signupFieldColor
        confirmEmailField.layer.borderWidth = 1
        confirmEmailField.keyboardType = .emailAddress
        return confirmEmailField
    }()
    
    lazy var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension()
        passwordField.placeholder = "Enter password"
        passwordField.font = Constants.signupFieldFont
        passwordField.layer.borderColor = Constants.signupFieldColor
        passwordField.layer.borderWidth = 1
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin" , size: 18)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    func setupConstraints() {
        
        addSubview(signupViewLabel)
        signupViewLabel.translatesAutoresizingMaskIntoConstraints = false
        signupViewLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        signupViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        signupViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupViewLabel.topAnchor.constraint(equalTo: topAnchor , constant: bounds.height * 0.05).isActive = true
        //signupViewLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -180).isActive = true
        
        
        addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        usernameField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        usernameField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameField.topAnchor.constraint(equalTo:signupViewLabel.bottomAnchor, constant: bounds.height * 0.05).isActive = true
        //usernameField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -110).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo:usernameField.bottomAnchor, constant: bounds.height * 0.05).isActive = true
        //emailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40).isActive = true
        
        addSubview(confirmEmailField)
        confirmEmailField.translatesAutoresizingMaskIntoConstraints = false
        confirmEmailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        confirmEmailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        confirmEmailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmEmailField.topAnchor.constraint(equalTo:emailField.bottomAnchor, constant: bounds.height * 0.05).isActive = true
        //confirmEmailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30).isActive = true
        
        addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo:confirmEmailField.bottomAnchor, constant: bounds.height * 0.05).isActive = true
        //passwordField.centerYAnchor.constraint(equalTo: centerYAnchor, constant:100).isActive = true
        passwordField.isSecureTextEntry = true
        
        addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor, multiplier:Constants.loginButtonWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * 0.06).isActive = true
        //signupButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 190).isActive = true
    }
}
