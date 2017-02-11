//
//  LoginView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    // MARK: UIElements
    
    var editState: Bool = false
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var emailField = TextFieldExtension().emailField("Enter email address") {
        didSet {
            print(emailField.text)
        }
    }
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
        initialOpacity()
        animated()
    }
    
    func initialOpacity() {
        loginButton.layer.opacity = 0
        emailField.layer.opacity = 0
        passwordField.layer.opacity = 0
        logoImageView.layer.opacity = 0
    }
    
    func animated() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.logoImageView.layer.opacity = 1
            self?.loginButton.layer.opacity = 1
            self?.emailField.layer.opacity = 1
            self?.passwordField.layer.opacity = 1
        })
    }
    
    /* Lays out subviews, adds delegate to textFields, adds selector method to signup button and loginButton add gesture recognizer tap*/
    
    func setupLogin(_ viewController: LoginViewController) {
        layoutSubviews()
        emailField.delegate = viewController
        passwordField.delegate = viewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action: #selector(viewController.dismissKeyboard))
        viewController.view.addGestureRecognizer(tap)
        loginButton.addTarget(viewController, action: #selector(viewController.handleLogin), for: .touchUpInside)
    }
    
    // MARK: - Configuring UI
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupLogoImage() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.12).isActive = true
    }
    
    fileprivate func setupConstraints() {
        setupLogoImage()
        setupView(view: emailField)
        emailField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: bounds.height * 0.1).isActive = true
        setupView(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * 0.06).isActive = true
        passwordField.isSecureTextEntry = true
        setupView(view: loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height  * 0.1).isActive = true
    }
    
    
    func textInputAnimation() {
        if editState != true {
            UIView.animate(withDuration: 0.5, animations: {
                self.logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
                self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
                self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * 0.05).isActive = true
                self.emailField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: self.bounds.height * 0.06).isActive = true
                self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: self.bounds.height  * 0.04).isActive = true
            })
        }
    }
    
    // MARK: - Animation
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 3, initialSpringVelocity: 0.0,  options: [.curveEaseInOut, .transitionCrossDissolve], animations: { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.emailField.layer.borderWidth = 1.2
                self.emailField.font = UIFont(name: "HelveticaNeue" , size: 16)
                self.emailField.textColor =  Constants.Color.backgroundColor
            } }, completion: { _ in
                let when = DispatchTime.now() + 0.32
                DispatchQueue.main.asyncAfter(deadline: when) { [unowned self] in
                    self.emailField.layer.borderWidth = 1
                    self.emailField.font = Constants.signupFieldFont
                    self.emailField.textColor = UIColor.lightGray
                    self.emailField.layer.borderColor = Constants.Color.backgroundColor.cgColor
                    self.emailField.layer.borderWidth = Constants.Border.borderWidth
                }
        })
    }
}
