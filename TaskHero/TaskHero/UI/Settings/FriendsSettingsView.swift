//
//  FriendSettingsView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsView: UIView {
    
    dynamic let taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add Friends"
        taskNameLabel.font = Constants.Font.headerFont
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        return taskNameLabel
    }()
    
    lazy var taskNameField: TextFieldExtension = {
        let taskNameField = TextFieldExtension()
        taskNameField.placeholder = "Search by email"
        taskNameField.font = Constants.signupFieldFont
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = 2
        taskNameField.layer.borderWidth = 1
        return taskNameField
    }()
    
    lazy var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.layer.borderWidth = 1
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        addTaskButton.layer.cornerRadius = 2
        addTaskButton.setTitle("Search", for: .normal)
        addTaskButton.setTitleColor(UIColor.white, for: .normal)
        return addTaskButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        taskNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.2).isActive = true
        
        addSubview(taskNameField)
        taskNameField.translatesAutoresizingMaskIntoConstraints = false
        taskNameField.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameField.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        taskNameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        taskNameField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -bounds.height * 0.1).isActive = true
        
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height * 0.1).isActive = true
    }
    
}
