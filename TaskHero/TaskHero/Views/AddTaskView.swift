//
//  AddTaskView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    let taskNameLabel: UITextView = {
        let taskNameLabel = UITextView()
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.font = UIFont(name: Constants.helveticaLight, size: 18)
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        taskNameLabel.isScrollEnabled = false
        return taskNameLabel
    }()
    
    
    lazy var taskNameField: LeftPaddedTextField = {
        let taskNameField = LeftPaddedTextField()
        taskNameField.placeholder = "Task name"
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = 2
        taskNameField.layer.borderWidth = 1
        return taskNameField
    }()
    
    
    var taskDescriptionLabel: UILabel = {
        let taskDescriptionLabel = UILabel()
        return taskDescriptionLabel
    }()
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.layer.borderWidth = 1
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.layer.cornerRadius = 2
        return taskDescriptionBox
    }()
    
    lazy var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.layer.borderWidth = 1
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        addTaskButton.layer.cornerRadius = 2
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(UIColor.white, for: .normal)
        return addTaskButton
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        taskNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        
        addSubview(taskNameField)
        taskNameField.translatesAutoresizingMaskIntoConstraints = false
        taskNameField.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameField.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        taskNameField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -240).isActive = true
        
        
        addSubview(taskDescriptionLabel)
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginFieldHeight).isActive = true
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -145).isActive = true
        
        addSubview(taskDescriptionBox)
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30).isActive = true
        taskDescriptionBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //
        //taskDescriptionBox.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        taskDescriptionBox.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 140).isActive = true
    }
    
}
