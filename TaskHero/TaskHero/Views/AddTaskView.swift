//
//  AddTaskView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    var taskNameLabel = UILabel()
    var taskNameTextField = UITextField()
    var taskDescriptionLabel = UILabel()
    var taskDescriptionTextView = UITextView()
    var addTaskButton = UIButton()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        taskNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -260).isActive = true
        
        addSubview(taskNameTextField)
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        taskNameTextField.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskNameTextField.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        taskNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200).isActive = true
        
        addSubview(taskDescriptionLabel)
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.loginTextFieldHeight).isActive = true
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -140).isActive = true
        
        addSubview(taskDescriptionTextView)
        taskDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        taskDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionTextView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        
        
        
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 180).isActive = true
    }
    
    func setupView() {
        taskNameLabel.text = "Task Name"
        taskNameLabel.font = UIFont(name: Constants.font, size: 20)
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.textAlignment = .center
        
        taskDescriptionLabel.text = "Task Description"
        taskDescriptionLabel.font = UIFont(name: Constants.font, size: 20)
        taskDescriptionLabel.textColor = UIColor.black
        taskDescriptionLabel.textAlignment = .center
        
        
        taskNameTextField.layer.borderWidth = 1
        taskNameTextField.layer.borderColor = UIColor.black.cgColor
        
        
        
        taskDescriptionTextView.layer.borderWidth = 1
        taskDescriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        addTaskButton.layer.borderWidth = 1
        addTaskButton.layer.borderColor = UIColor.black.cgColor
        
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
