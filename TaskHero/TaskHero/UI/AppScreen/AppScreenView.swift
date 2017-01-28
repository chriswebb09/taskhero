//
//  AppScreenView.swift
//
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//
//

import UIKit

class AppScreenView: UIView {
    
    var viewModel: AppScreenViewModel = {
        return AppScreenViewModel()
    }()
    
     var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:viewModel.signupButtonColor)
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
    
    fileprivate func setupConstraints() {
        addSubview(loginButton)
        addSubview(signupButton)
        addSubview(viewDivider)
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        setupViewDivider()
        loginButton.bottomAnchor.constraint(equalTo: viewDivider.topAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: UIScreen.main.bounds.height * 0.1).isActive = true
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupViewDivider() {
        viewDivider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}

