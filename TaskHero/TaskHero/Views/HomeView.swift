//
//  HomeView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    var settingsViewLabel = UILabel()
    var firstNameLabel = UILabel()
    var lastNameLabel = UILabel()
    var usernameLabel = UILabel()
    var emailAddressLabel = UILabel()
    var privacySettings = UIButton()
    var changeNameButton = UIButton()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        addSubview(settingsViewLabel)
        settingsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsViewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.settingsViewLabelWidth).isActive = true
        settingsViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.settingsViewLabelHeight).isActive = true
        settingsViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingsViewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        
        
        addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.settingsViewLabelWidth).isActive = true
        firstNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.settingsViewLabelHeight).isActive = true
        firstNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -140).isActive = true
        firstNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        
        addSubview(lastNameLabel)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.settingsViewLabelWidth).isActive = true
        lastNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.settingsViewLabelHeight).isActive = true
        lastNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80).isActive = true
        lastNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.settingsViewLabelWidth).isActive = true
        usernameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.settingsViewLabelHeight).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        
        addSubview(emailAddressLabel)
        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        emailAddressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.settingsViewLabelWidth).isActive = true
        emailAddressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.settingsViewLabelHeight).isActive = true
        emailAddressLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40).isActive = true
        emailAddressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
    }
    
    func setupView() {
        
        settingsViewLabel.textColor = UIColor.black
        settingsViewLabel.text = "Settings"
        settingsViewLabel.textAlignment = .center
        settingsViewLabel.font = Constants.settingsFont
        
        firstNameLabel.textColor = UIColor.black
        firstNameLabel.sizeToFit()
        firstNameLabel.font = Constants.settingsFont
        
        lastNameLabel.textColor = UIColor.black
        lastNameLabel.font = Constants.settingsFont
        lastNameLabel.sizeToFit()
        
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = Constants.settingsFont
        usernameLabel.sizeToFit()
        
        emailAddressLabel.textColor = UIColor.black
        emailAddressLabel.font = Constants.settingsFont
        emailAddressLabel.sizeToFit()
    }
}

