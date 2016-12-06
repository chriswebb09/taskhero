//
//  AddTaskView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    let taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.font = Constants.Font.fontLarge
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        return taskNameLabel
    }()
    
    lazy var taskNameField: TextFieldExtension = {
        let taskNameField = TextFieldExtension()
        taskNameField.placeholder = "Task name"
        taskNameField.font = Constants.signupFieldFont
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskNameField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        return taskNameField
    }()
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskDescriptionBox.font = Constants.signupFieldFont
        taskDescriptionBox.contentInset = Constants.TaskCell.boxInset
        return taskDescriptionBox
    }()
    
    lazy var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = Constants.AddTask.buttonBackgroundColor
        addTaskButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
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
        taskNameLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.TaskList.taskListNameWidth).isActive = true
        taskNameLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        taskNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
        
        addSubview(taskNameField)
        
        taskNameField.translatesAutoresizingMaskIntoConstraints = false
        taskNameField.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.TaskList.taskListNameWidth).isActive = true
        taskNameField.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        taskNameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.AddTask.taskNameField).isActive = true
        taskNameField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskNameField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
        
        addSubview(taskDescriptionBox)
        
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.TaskList.taskListNameWidth).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.AddTask.boxHeight).isActive = true
        taskDescriptionBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: bounds.height * Constants.AddTask.boxTopOffset).isActive = true
        
        addSubview(addTaskButton)
        
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.AddTask.boxWidth).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.AddTask.buttonHeight).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
    }
    
}
