//
//  InitView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/26/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class InitView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "TaskHeroLogoNew2")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    
    lazy var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    lazy var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:Constants.Init.signupButtonColor)
        return button.newButton
    }()
    
    lazy var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
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
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Logo.logoImageWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Logo.logoImageHeight).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Login.loginLogoTopSpacing).isActive = true
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.Login.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        addSubview(viewDivider)
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: bounds.height * Constants.Login.loginElementSpacing).isActive = true
        
        
        addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: bounds.height * Constants.Login.loginSignupElementSpacing).isActive = true
    }
}
