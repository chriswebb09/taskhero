//
//  SignupView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SignupView: UIView {
    
    let createAccountLabel = UILabel()
    
    let createNewUserButton = UIButton()
    
    let signUpButton = UIButton()
    
    let emailAddressTextField = UITextField()
    let confirmEmailAddressTextField = UITextField()
    
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    
    let emailAddressLabel = UILabel()
    let confirmEmailAddressLabel = UILabel()
    
    let passwordLabel = UILabel()
    let confirmPasswordLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        
        addSubview(createAccountLabel)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        //createAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //createAccountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        createAccountLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        createAccountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        createAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(emailAddressLabel)
        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        emailAddressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        emailAddressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        emailAddressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailAddressLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -210).isActive = true
        
        addSubview(emailAddressTextField)
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        emailAddressTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        emailAddressTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailAddressTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant:-170).isActive = true
        
        addSubview(confirmEmailAddressLabel)
        confirmEmailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmEmailAddressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        confirmEmailAddressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        confirmEmailAddressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmEmailAddressLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -110).isActive = true
        
        addSubview(confirmEmailAddressTextField)
        confirmEmailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmEmailAddressTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        confirmEmailAddressTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        confirmEmailAddressTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmEmailAddressTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70).isActive = true
        
        addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30).isActive = true
        
        addSubview(confirmPasswordLabel)
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        confirmPasswordLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        confirmPasswordLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmPasswordLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 90).isActive = true
        
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        confirmPasswordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmPasswordTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 130).isActive = true
        
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.widthAnchor.constraint(equalTo: emailAddressTextField.widthAnchor, multiplier:0.5).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: emailAddressTextField.heightAnchor).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signUpButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 230).isActive = true
    }
    
    func setupView() {
        createAccountLabel.text = "Become a Member"
        createAccountLabel.textAlignment = .center
        createAccountLabel.textColor = UIColor.black
        createAccountLabel.font = Constants.settingsFont
        //createAccountLabel.backgroundColor = UIColor.blue
        
        createAccountLabel.font = UIFont(name: Constants.font, size: 28)
        createAccountLabel.sizeToFit()
        
        
        emailAddressLabel.text = "Email"
        emailAddressLabel.textAlignment = .center
        emailAddressLabel.font = Constants.settingsFont
        
        emailAddressTextField.layer.borderWidth = 1
        emailAddressTextField.layer.cornerRadius = 4
        emailAddressTextField.layer.borderColor = UIColor.black.cgColor
        
        
        confirmEmailAddressLabel.text = "Confirm Email"
        confirmEmailAddressLabel.textAlignment = .center
        confirmEmailAddressLabel.font = Constants.settingsFont
        
        confirmEmailAddressTextField.layer.borderWidth = 1
        confirmEmailAddressTextField.layer.cornerRadius = 4
        confirmEmailAddressTextField.layer.borderColor = UIColor.black.cgColor
        
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .center
        passwordLabel.font = Constants.settingsFont
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        
        confirmPasswordLabel.text = "Confirm Password"
        confirmPasswordLabel.textAlignment = .center
        confirmPasswordLabel.font = Constants.settingsFont
        
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
        confirmPasswordTextField.layer.cornerRadius = 4
        
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    
}
