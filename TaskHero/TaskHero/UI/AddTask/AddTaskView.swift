//
//  AddTaskView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class AddTaskView: UIView {
    
    // MARK: - Deallocate AddTaskView From Memory
    
    deinit {
        print("AddTaskView deallocated")
    }
    
    // MARK: UI Elements
    
    var taskNameLabel: UILabel {
        let taskNameLabel = UILabel()
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.font = Constants.Font.fontLarge
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        return taskNameLabel
    }
    
    var taskNameField: TextFieldExtension {
        let taskNameField = TextFieldExtension()
        taskNameField.placeholder = "Task name"
        taskNameField.font = Constants.signupFieldFont
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskNameField.layer.borderWidth = Constants.Border.borderWidth
        return taskNameField
    }
    
    var taskDescriptionBox: UITextView {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.layer.borderWidth = Constants.Border.borderWidth
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskDescriptionBox.font = Constants.signupFieldFont
        taskDescriptionBox.contentInset = Constants.TaskCell.Description.boxInset
        return taskDescriptionBox
    }
    
    var addTaskButton: UIButton {
        let addTaskButton = UIButton()
        addTaskButton.layer.borderWidth = Constants.Border.borderWidth
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = Constants.Color.buttonColor
        addTaskButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(UIColor.white, for: .normal)
        return addTaskButton
    }
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    // MARK: - Configure
    
    fileprivate func configureView(view: UIView) {
        configureUIElements(view: view)
        view.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        view.heightAnchor.constraint(equalTo:heightAnchor, multiplier: 0.07).isActive = true
    }
    
    func addTaskDescriptionBox(taskDescriptionBox: UITextView) {
        configureUIElements(view: taskDescriptionBox)
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
    }
    
    fileprivate func configureUIElements(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addButton(addTaskButton: UIButton) {
        configureUIElements(view: addTaskButton)
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
    }
    
    fileprivate func setupConstraints() {
        configureView(view: taskNameLabel)
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
        configureView(view: taskNameField)
        taskNameField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: bounds.height * Constants.AddTask.topAnchorOffset).isActive = true
        addTaskDescriptionBox(taskDescriptionBox: taskDescriptionBox)
        addButton(addTaskButton: addTaskButton)
    }
}
