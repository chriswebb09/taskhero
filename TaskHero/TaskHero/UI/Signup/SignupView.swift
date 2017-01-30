//
//  SignupView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SignupView: UIView {
//    lazy var logoImageView: UIImageView = {
//        let image = UIImage(named: "TaskHeroLogoNew2")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
//    
//    lazy var logoImageView: UILabel = {
//        let label = UILabel()
//        label.text = "Signup"
//        return label
////        let image = UIImage(named: "TaskHeroLogoNew2")
////        let imageView = UIImageView(image: image)
////        return imageView
//    }()

    
    lazy var registerLabel: UILabel = {
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
    
    lazy var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Enter email address")
        return emailField
    }()
    
    lazy var confirmEmailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Confirm email address")
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
    
//    lazy var signupButton: UIButton = {
//        let button = ButtonType.system(title:"Register Now", color:Constants.Color.backgroundColor)
//        return button.newButton
//    }()
    
//    lazy var viewDivider: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
//        return view
//    }()
    
//    lazy var registerLabel: UILabel = {
//        let registerLabel = UILabel()
//        registerLabel.textColor = Constants.Color.backgroundColor
//        registerLabel.text = "Don't have an account?"
//        registerLabel.font = Constants.Font.fontLarge
//        registerLabel.textAlignment = .center
//        return registerLabel
//    }()
//    
    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
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
        registerLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Login.loginLogoTopSpacing).isActive = true
    }
    
//    private func setupViewDivider() {
//        addSubview(viewDivider)
//        viewDivider.translatesAutoresizingMaskIntoConstraints = false
//        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
//        viewDivider.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
//        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        viewDivider.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
//    }
    
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
        
        usernameField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        setupView(view: emailField)
        
        emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        setupView(view: confirmEmailField)
        
        confirmEmailField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        setupView(view: passwordField)
        
        
        passwordField.topAnchor.constraint(equalTo: confirmEmailField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        passwordField.isSecureTextEntry = true
        
        
        
        setupView(view: loginButton)
        
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
     //   setupViewDivider(viewDivider: loginButton)
   //     setupView(view: registerLabel)
//        registerLabel.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: bounds.height * Constants.Login.loginSignupElementSpacing).isActive = true
      //  setupView(view: signupButton)
//        signupButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: bounds.height * Constants.Login.loginSignupElementSpacing).isActive = true
    }
}

    
//    var signupViewModel: SignupViewModel = {
//        return SignupViewModel(signup: "Become a Member")
//    }()
//    
//    var signupViewLabel: UILabel {
//        let signupViewLabel = UILabel()
//        signupViewLabel.textColor = UIColor.black
//        signupViewLabel.text = signupViewModel.signupTitle
//        signupViewLabel.font = Constants.Font.fontLarge
//        signupViewLabel.textAlignment = .center
//        return signupViewLabel
//    }
//    
//    var usernameField: TextFieldExtension {
//        let emailField = TextFieldExtension().emailField("Choose a username")
//        return emailField
//    }
//    
//    var emailField: TextFieldExtension {
//        let emailField = TextFieldExtension().emailField("Enter email address")
//        return emailField
//    }
//    
//    var confirmEmailField: TextFieldExtension {
//        let emailField = TextFieldExtension().emailField("Confirm email address")
//        return emailField
//    }
//    
//    var passwordField: TextFieldExtension {
//        let passwordField = TextFieldExtension().passwordField()
//        return passwordField
//    }
//    
//    var signupButton: UIButton {
//        let button = UIButton(type: .system)
//        button.backgroundColor = signupViewModel.buttonColor
//        button.setTitle("Sign Up", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = Constants.Font.fontNormal
//        return button
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        backgroundColor = UIColor.white
//        frame = UIScreen.main.bounds
//        self.addSubview(signupViewLabel)
//        signupViewLabel.translatesAutoresizingMaskIntoConstraints = false
//        //setupConstraints()
//    }
//}

//    func configureField(field: UIView) {
//        addSubview(field)
//        field.translatesAutoresizingMaskIntoConstraints = false
//        field.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Dimension.width).isActive = true
//        field.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.buttonHeight).isActive = true
//        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
    
    /* sets up constraints on signupview */
    
//    func setupConstraints() {
//       // configureField(field: signupViewLabel)
//      //  addSubview(signupViewLabel)
//       // signupViewLabel.translatesAutoresizingMaskIntoConstraints = false
//        //signupViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        signupViewLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Dimension.width).isActive = true
//        signupViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.buttonHeight).isActive = true
//        signupViewLabel.topAnchor.constraint(equalTo: topAnchor , constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
//        configureField(field: usernameField)
//        usernameField.topAnchor.constraint(equalTo:signupViewLabel.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
//        configureField(field: emailField)
//        emailField.topAnchor.constraint(equalTo:usernameField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
//        configureField(field: confirmEmailField)
//        confirmEmailField.topAnchor.constraint(equalTo:emailField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
//        addPasswordField(passwordField: passwordField)
//        addSignupButton(signupButton: signupButton)
 //   }
    
//    func addPasswordField(passwordField: UITextField) {
//        configureField(field: passwordField)
//        passwordField.topAnchor.constraint(equalTo:confirmEmailField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
//        passwordField.isSecureTextEntry = true
//    }
//    
//    func addSignupButton(signupButton: UIButton) {
//        addSubview(signupButton)
//        configureField(field: signupButton)
//        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * Constants.Signup.buttonTopOffset).isActive = true
//    }
