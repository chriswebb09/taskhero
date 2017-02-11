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
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color: Constants.Color.mainColor)
        return button.newButton
    }()
    
    var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
}

extension AppScreenView {

    fileprivate func setupConstraints() {
        setupLogoImage(logoImageView: logoImageView)
        constraintSetup(views: [viewDivider, loginButton, signupButton])
        setupViewDivider(viewDivider: viewDivider)
        loginButton.bottomAnchor.constraint(equalTo: viewDivider.topAnchor, constant: UIScreen.main.bounds.height * -0.04).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier:0.075).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: UIScreen.main.bounds.height * 0.04).isActive = true
        signupButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        signupButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier:0.075).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupLogoImage(logoImageView: UIView) {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height * -0.2).isActive = true
    }
    
    func buttonSetup(buttons: [UIButton]) {
        // Not implemented yet
    }
    
    private func constraintSetup(views: [UIView]) {
        _ = views.map { addSubview($0) }
        _ = views.map { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupViewDivider(viewDivider: UIView) {
        viewDivider.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0.09).isActive = true
        viewDivider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewDivider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.dividerWidth).isActive = true
        viewDivider.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier:  Constants.Login.dividerHeight).isActive = true
    }
}

