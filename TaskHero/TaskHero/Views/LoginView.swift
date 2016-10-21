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
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        button.setAttributedTitle( NSAttributedString(string: "Log In", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin" , size: 18)!]), for: .normal)
        button.layer.cornerRadius = 2
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle( NSAttributedString(string: "Register Now", attributes: [NSForegroundColorAttributeName: UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0), NSFontAttributeName:UIFont(name: "HelveticaNeue-Thin" , size: 18)!]), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 2
        button.layer.borderColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
        return button
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
        registerLabel.font = UIFont(name: "HelveticaNeue-Thin" , size: 18)
        registerLabel.textAlignment = .center
        return registerLabel
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
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -180).isActive = true
        
        addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        emailField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        emailField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -110).isActive = true
        
        addSubview(passwordField)
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        passwordField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordField.centerYAnchor.constraint(equalTo: centerYAnchor, constant:-30).isActive = true
        passwordField.isSecureTextEntry = true
        
        addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        
        addSubview(viewDivider)
        
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier: 0.02).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 110).isActive = true
        
        addSubview(registerLabel)
        
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        registerLabel.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 150).isActive = true
        
        addSubview(signupButton)
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 210).isActive = true
    }
}


