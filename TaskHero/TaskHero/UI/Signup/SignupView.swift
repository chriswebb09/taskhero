//
//  SignupView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SignupView: UIView {
    
    var registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = Constants.Color.backgroundColor
        registerLabel.text = "Don't have an account?"
        registerLabel.font = Constants.Font.fontLarge
        registerLabel.textAlignment = .center
        return registerLabel
    }()
    
    var usernameField: TextFieldExtension = {
        let usernameField = TextFieldExtension().emailField("Choose a username")
        return usernameField
    }()
    
    var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Enter email address")
        return emailField
    }()
    
    var confirmEmailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Confirm email address")
        return emailField
    }()
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Sign Up")
        return button.newButton
    }()
    
}

extension SignupView {

    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupLogoImage() {
        addSubview(registerLabel)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Logo.logoImageWidth).isActive = true
        registerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Logo.logoImageHeight).isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.08).isActive = true
    }
    
    private func setupViewDivider(viewDivider: UIView) {
        addSubview(viewDivider)
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
    }
    
    fileprivate func setupConstraints() {
        setupLogoImage()
        setupView(view: usernameField)
        usernameField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: bounds.height * 0.065).isActive = true
        setupView(view: emailField)
        emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        setupView(view: confirmEmailField)
        confirmEmailField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        setupView(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: confirmEmailField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        passwordField.isSecureTextEntry = true
        setupView(view: loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * 0.085).isActive = true
        
    }
}

