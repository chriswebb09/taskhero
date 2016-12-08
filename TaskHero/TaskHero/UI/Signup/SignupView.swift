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
        signupViewLabel.font = Constants.Font.fontLarge
        signupViewLabel.textAlignment = .center
        return signupViewLabel
    }()
    
    lazy var usernameField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField(placeholder: "Choose a username")
        return emailField
    }()
    
    lazy var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField(placeholder: "Enter email address")
        return emailField
    }()
    
    lazy var confirmEmailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField(placeholder: "Confirm email address")
        return emailField
    }()
    
    lazy var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor.newButtonColor()
        button.backgroundColor = Constants.Login.loginButtonColor
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.fontNormal
        return button
    }()
}

extension SignupView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    // sets up constraints on signupview
    
    fileprivate func setupConstraints() {
        addSubview(signupViewLabel)
        signupViewLabel.translatesAutoresizingMaskIntoConstraints = false
        signupViewLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        signupViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        signupViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupViewLabel.topAnchor.constraint(equalTo: topAnchor , constant: bounds.height * Constants.Signup.entryFieldTopOffset).isActive = true
        
        
        addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        usernameField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        usernameField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameField.topAnchor.constraint(equalTo:signupViewLabel.bottomAnchor, constant: bounds.height * Constants.Signup.entryFieldTopOffset).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo:usernameField.bottomAnchor, constant: bounds.height * Constants.Signup.entryFieldTopOffset).isActive = true
        
        
        addSubview(confirmEmailField)
        confirmEmailField.translatesAutoresizingMaskIntoConstraints = false
        confirmEmailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        confirmEmailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        confirmEmailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmEmailField.topAnchor.constraint(equalTo:emailField.bottomAnchor, constant: bounds.height * Constants.Signup.entryFieldTopOffset).isActive = true
        
        addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo:confirmEmailField.bottomAnchor, constant: bounds.height * Constants.Signup.entryFieldTopOffset).isActive = true
        passwordField.isSecureTextEntry = true
        
        addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.Login.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * Constants.Signup.buttonTopOffset).isActive = true
    }
}
