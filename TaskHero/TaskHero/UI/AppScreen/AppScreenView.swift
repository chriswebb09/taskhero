//
//  AppScreenView.swift
//  
//
//  Created by Christopher Webb-Orenstein on 1/27/17.
//
//

import UIKit

class AppScreenView: UIView {
    
    lazy var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    lazy var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:Constants.Color.backgroundColor)
        return button.newButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupConstraints() {
        
    }
    
    func setupView() {
        
    }
}

