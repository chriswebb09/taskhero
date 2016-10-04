//
//  LoginView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var loginLabel = UILabel()
    var newUserButton = UIButton()
    var userNameLabel = UILabel()
    var usernameTextField = UITextField()
    var passwordLabel = UILabel()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    var logoImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        
        
        addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        logoImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200).isActive = true
        
        addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200).isActive = true
        
        addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -140).isActive = true
        
        addSubview(usernameTextField)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        
        addSubview(passwordLabel)
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.loginTextFieldWidth).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40).isActive = true
        
        addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.searchTextFieldWidth).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.searchTextFieldHeight).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        passwordTextField.isSecureTextEntry = true
        
        addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier:Constants.loginButtonWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
        
        addSubview(newUserButton)
        
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier:Constants.loginButtonWidth).isActive = true
        newUserButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        newUserButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        newUserButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 160).isActive = true
    }
    
    
    func setupView() {
        
        backgroundColor = UIColor.white
        
        loginLabel.textColor = UIColor.black
        loginLabel.textAlignment = .center
        loginLabel.text = "Log In"
        loginLabel.font = UIFont(name: Constants.font, size: 30)
        
        userNameLabel.textColor = UIColor.black
        userNameLabel.text = "Username"
        
        passwordLabel.textColor = UIColor.black
        passwordLabel.text = "Password"
        
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        usernameTextField.placeholder = "Email Address"
        usernameTextField.autocapitalizationType = .none
        ///usernameTextField.drawText(CGRect(x: bounds.origin.x + 30, y: bounds.origin.y, width: bounds.width, height: bounds.height))
        
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        //passwordTextField.layer.cornerRadius = 4
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.setTitle("Log In", for:.normal)
        loginButton.titleLabel?.font = UIFont(name: Constants.font, size: 20)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        //loginButton.layer.cornerRadius = 4
        
        let userAttributedString = NSAttributedString(string: "Not a member yet?", attributes: [NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue, NSForegroundColorAttributeName:UIColor.gray])
        
        newUserButton.titleLabel?.font = UIFont(name: Constants.font, size: 16)
        newUserButton.setAttributedTitle(userAttributedString, for: .normal)
        
        logoImage.image = UIImage(named: "logo")
        
        logoImage.isHidden = true 
    }
    
}
