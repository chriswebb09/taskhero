//
//  TaskCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


protocol TaskCellDelegate: class {
    func toggleForEditState(sender:UIGestureRecognizer)
    func toggleForButtonState(sender:UIButton)
}

class TaskCell: UITableViewCell {
    
    static let cellIdentifier = "TaskCell"
    
    weak var delegate: TaskCellDelegate?
    var toggled: Bool? = false
    var buttonToggled: Bool = false
    
    // MARK: - Setup UI Elements
    
    let taskNameLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = Constants.Font.bolderFontLarge
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.layer.borderWidth = Constants.Settings.searchButtonWidth
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskDescriptionBox.font = Constants.signupFieldFont
        taskDescriptionBox.contentInset = Constants.TaskCell.boxInset
        return taskDescriptionBox
    }()
    
    let taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Constants.TaskCell.descriptionLabelBackgroundColor
        textView.textColor = UIColor.white
        textView.layer.cornerRadius = Constants.TaskCell.cornerRadius
        textView.font = Constants.Font.fontMedium
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let taskDueLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = Constants.Font.fontMedium
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    var taskCompletedView: UIImageView = {
        let taskCompletedImageView = UIImageView()
        taskCompletedImageView.isUserInteractionEnabled = true
        return taskCompletedImageView
    }()
    
    var saveButton: UIButton = {
        let button = ButtonType.system(title: "Save", color: UIColor.babyBlueColor())
        var ui = button.newButton
        ui.isHidden = true
        ui.isEnabled = false
        return ui
    }()
}

extension TaskCell {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Configure cell
    
    func setupConstraints() {
        contentView.addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.nameLabelHeight).isActive = true
        taskNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.dueWidth).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.TaskCell.nameLabelTopOffset).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:Constants.TaskCell.nameLabelLeftOffset).isActive = true
        
        contentView.addSubview(taskDueLabel)
        taskDueLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDueLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.nameLabelHeight).isActive = true
        taskDueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.dueWidth).isActive = true
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:Constants.TaskCell.dueTopOffset).isActive = true
        
        
        contentView.addSubview(taskDescriptionLabel)
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.descriptionBoxHeight).isActive = true
        taskDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.descriptionLabelWidth).isActive = true
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.TaskCell.descriptionsLabelBottomOffset).isActive = true
        
        contentView.addSubview(taskCompletedView)
        taskCompletedView.translatesAutoresizingMaskIntoConstraints = false
        taskCompletedView.heightAnchor.constraint(equalToConstant: Constants.TaskCell.completedHeight).isActive = true
        taskCompletedView.widthAnchor.constraint(equalToConstant: Constants.TaskCell.completedHeight).isActive = true
        taskCompletedView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.completedViewRightOffset).isActive = true
        taskCompletedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.TaskCell.completedTopOffset).isActive = true
        
        contentView.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonHeight).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth).isActive = true
        saveButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.saveButtonRightOffset).isActive = true
        saveButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.TaskCell.saveButtonTopOffset).isActive = true
        
        contentView.addSubview(taskDescriptionBox)
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.descriptionBoxHeight).isActive = true
        taskDescriptionBox.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.descriptionLabelWidth).isActive = true
        taskDescriptionBox.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDescriptionBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.TaskCell.descriptionsLabelBottomOffset).isActive = true
    }
    
    func configureCell(task:Task) {
        taskDescriptionBox.isHidden = true
        taskNameLabel.text = task.taskName
        taskDueLabel.text = "Due date: \(task.taskDue)"
        taskDescriptionLabel.text = task.taskDescription
        saveButton.addTarget(self, action: #selector(toggleForButtonState), for: .touchUpInside)
        layoutSubviews()
        styleAppearance()
        if task.taskCompleted {
            taskCompletedView.image = UIImage(named:"checked")
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleForEditState))
            taskCompletedView.addGestureRecognizer(tap)
            saveButton.addTarget(self, action: #selector(toggleForButtonState(sender:)), for: .touchUpInside)
        } else {
            taskCompletedView.image = UIImage(named:"edit")
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleForEditState))
            taskCompletedView.addGestureRecognizer(tap)
        }
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        contentView.backgroundColor = UIColor.clear
    }
    
    func setupCellView(width: CGFloat, height: CGFloat) {
        let cellView : UIView = UIView(frame: CGRect(x:0, y:1, width:width, height:height))
        
        cellView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = Constants.TaskCell.cornerRadius
        cellView.layer.shadowOffset = Constants.TaskCell.shadowOffset
        cellView.layer.shadowOpacity = Constants.TaskCell.styledShadowOpacity
        
        contentView.addSubview(cellView)
        contentView.sendSubview(toBack: cellView)
    }
    
    func styleAppearance() {
        layer.masksToBounds = false
        layer.shadowOffset = Constants.TaskCell.styledShadowRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = Constants.TaskCell.shadowRadius
        layer.shadowOpacity = Constants.TaskCell.shadowOpacity
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
    
}
