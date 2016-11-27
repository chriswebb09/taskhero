//
//  LoginView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "TaskHeroLogoNew2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension()
        emailField.placeholder = "Enter email"
        emailField.layer.borderColor = Constants.signupFieldColor
        emailField.layer.borderWidth = 1
        emailField.layer.cornerRadius = 2
        emailField.font = Constants.signupFieldFont
        emailField.keyboardType = .emailAddress
        return emailField
    }()
    
    lazy var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension()
        passwordField.placeholder = "Enter password"
        passwordField.font = Constants.signupFieldFont
        passwordField.layer.borderColor = Constants.signupFieldColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 2
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    lazy var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0))
        return button.newButton
    }()
    
    lazy var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        registerLabel.text = "Don't have an account?"
        registerLabel.font = UIFont(name: Constants.Font.helveticaThin , size: 18)
        registerLabel.textAlignment = .center
        return registerLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
        
        loginButton.layer.opacity = 0
        emailField.layer.opacity = 0
        passwordField.layer.opacity = 0
        registerLabel.layer.opacity = 0
        signupButton.layer.opacity = 0
        viewDivider.layer.opacity = 0
        logoImageView.layer.opacity = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImageView.layer.opacity = 1
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.loginButton.layer.opacity = 1
            self.registerLabel.layer.opacity = 1
            self.signupButton.layer.opacity = 1
            self.viewDivider.layer.opacity = 1
            self.emailField.layer.opacity = 1
            self.passwordField.layer.opacity = 1
        })
    }
    
    fileprivate func setupConstraints() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.logoImageWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.logoImageHeight).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Login.loginLogoTopSpacing).isActive = true
        
        addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        passwordField.isSecureTextEntry = true
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.Login.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        addSubview(viewDivider)
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        addSubview(registerLabel)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        registerLabel.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: bounds.height * Constants.Login.loginSignupElementSpacing).isActive = true
        
        addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: bounds.height * Constants.Login.loginSignupElementSpacing).isActive = true
    }
}


