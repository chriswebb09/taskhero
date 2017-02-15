//
//  AddTaskView.swift
//  TaskHero
//

import UIKit

final class AddTaskView: UIView {
    
    // MARK: UI Elements
    
    var taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.font = Constants.Font.fontLarge
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        return taskNameLabel
    }()
    
    var taskNameField = TextFieldExtension().emailField("Task name") {
        didSet {
            print(taskNameField.text)
        }
    }
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.text = "Describe what you want to get done."
        taskDescriptionBox.layer.borderWidth = Constants.Border.borderWidth
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.textColor = .lightGray
        taskDescriptionBox.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskDescriptionBox.font = Constants.signupFieldFont
        taskDescriptionBox.contentInset = Constants.TaskCell.Description.boxInset
        return taskDescriptionBox
    }()
    
    var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.layer.borderWidth = Constants.Border.borderWidth
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = Constants.Color.buttonColor
        addTaskButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(.white, for: .normal)
        return addTaskButton
    }()
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    func setBorder(view: UIView) {
        view.layer.borderWidth = Constants.Border.borderWidth
    }
    
    // MARK: - Configure
    
    fileprivate func configureView(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        view.heightAnchor.constraint(equalTo:heightAnchor, multiplier: 0.07).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setupConstraints() {
        configureView(view: taskNameLabel)
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.05).isActive = true
        configureView(view: taskNameField)
        taskNameField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: bounds.height * 0.05).isActive = true
        addSubview(taskDescriptionBox)
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        taskDescriptionBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: bounds.height *  0.05).isActive = true
    }
    
    func animatiedPostion() {
        UIView.animate(withDuration: 0.05) {
            self.taskNameLabel.isHidden = true
            if self.taskNameField.isFirstResponder {
                self.taskNameField.layer.borderColor = UIColor.gray.cgColor
            } else if self.taskDescriptionBox.isFirstResponder {
                self.taskDescriptionBox.layer.borderColor = UIColor.gray.cgColor
            }
            self.taskNameField.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * 0.04).isActive = true
            self.taskDescriptionBox.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
            self.taskDescriptionBox.topAnchor.constraint(equalTo: self.taskNameField.bottomAnchor, constant: self.bounds.height * 0.02).isActive = true
            self.addTaskButton.topAnchor.constraint(equalTo: self.taskDescriptionBox.bottomAnchor, constant: self.bounds.height *  0.02).isActive = true
            self.layoutIfNeeded()
        }
    }
    
    func normal() {
        
    }
}
