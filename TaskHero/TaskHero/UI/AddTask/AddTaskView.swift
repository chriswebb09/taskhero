//
//  AddTaskView.swift
//  TaskHero
//

import UIKit
import SnapKit

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
            print(taskNameField.text ?? "No task name")
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
        view.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(0.85)
            make.height.equalTo(self).multipliedBy(0.07)
            make.centerX.equalTo(self)
        }
    }
    
    fileprivate func setupConstraints() {
        configureView(view: taskNameLabel)
        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(bounds.height * 0.05)
        }
        configureView(view: taskNameField)
        taskNameField.snp.makeConstraints { make in
            make.top.equalTo(taskNameLabel.snp.bottom).offset(bounds.height * 0.05)
        }
        addSubview(taskDescriptionBox)
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(0.85)
            make.height.equalTo(self).multipliedBy(0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(taskNameField.snp.bottom).offset(bounds.height * Constants.Dimension.settingsOffset)
        }
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(self).multipliedBy(0.07)
            make.centerX.equalTo(self)
            make.top.equalTo(taskDescriptionBox.snp.bottom).offset(bounds.height * 0.05)
        }
    }
    
    func animatedPostion() {
        self.taskNameLabel.isHidden = true
        if self.taskNameField.isFirstResponder {
            self.taskNameField.layer.borderColor = UIColor.gray.cgColor
        } else if self.taskDescriptionBox.isFirstResponder {
            self.taskDescriptionBox.layer.borderColor = UIColor.gray.cgColor
        }
        self.taskNameField.snp.makeConstraints { make in
            make.top.equalTo(self).offset(self.bounds.height * 0.04)
        }
        self.taskDescriptionBox.snp.makeConstraints { make in
            make.height.equalTo(self).multipliedBy(0.2)
            make.top.equalTo(self.taskNameField.snp.bottom).offset(self.bounds.height * 0.02)
        }
        self.addTaskButton.snp.makeConstraints { make in
            make.top.equalTo(self.taskDescriptionBox.snp.bottom).offset(self.bounds.height * 0.02)
        }
        UIView.animate(withDuration: 0.05) {
            self.layoutIfNeeded()
        }
    }
}
