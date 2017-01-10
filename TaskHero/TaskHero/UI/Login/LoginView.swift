//
//  LoginView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    // =========================
    // MARK: UIElements
    // =========================
    
    deinit {
        print("loginview deallocated")
    }
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "TaskHeroLogoNew2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField(placeholder: "Enter email address")
        return emailField
    }()
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    lazy var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    lazy var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:Constants.Color.backgroundColor)
        return button.newButton
    }()
    
    lazy var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = Constants.Color.backgroundColor
        registerLabel.text = "Don't have an account?"
        registerLabel.font = Constants.Font.fontLarge
        registerLabel.textAlignment = .center
        return registerLabel
    }()
}


extension LoginView {
    
    // ==============================
    // MARK: Initialization
    // ==============================
    
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
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.logoImageView.layer.opacity = 1
            self?.loginButton.layer.opacity = 1
            self?.registerLabel.layer.opacity = 1
            self?.signupButton.layer.opacity = 1
            self?.viewDivider.layer.opacity = 1
            self?.emailField.layer.opacity = 1
            self?.passwordField.layer.opacity = 1
        })
    }
    
    func setupLogin(viewController: LoginViewController) {
        layoutSubviews()
        emailField.delegate = viewController
        passwordField.delegate = viewController
        signupButton.addTarget(viewController, action: #selector(viewController.signupButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action: #selector(viewController.dismissKeyboard))
        viewController.view.addGestureRecognizer(tap)
        loginButton.addTarget(viewController, action: #selector(viewController.handleLogin), for: .touchUpInside)
    }
    
    // ===============================
    // MARK: - Configuring UI
    // ===============================
    
    func configure(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setupConstraints() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Logo.logoImageWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Logo.logoImageHeight).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Login.loginLogoTopSpacing).isActive = true
        configure(view: emailField)
        emailField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        configure(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        passwordField.isSecureTextEntry = true
        configure(view: loginButton)
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


extension LoginView {
    
    // ===============================
    // MARK: - Animation
    // ===============================
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 3, initialSpringVelocity: 0.0,  options: [.curveEaseInOut, .transitionCrossDissolve], animations: { [unowned self] in
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
