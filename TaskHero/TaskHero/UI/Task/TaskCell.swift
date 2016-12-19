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
    var toggled:Bool = false
    var taskViewModel: TaskCellViewModel!
    
    // MARK: - Setup UI Elements
    
    let taskNameLabel: UITextView = {
        let textView = UITextView()
        
        textView.textColor = UIColor.black
        textView.font = Constants.Font.bolderFontLarge
        
        return textView
    }()
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.isHidden = true
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
        
        return textView
    }()
    
    let taskDueLabel: UITextView = {
        let textView = UITextView()
        
        textView.textColor = UIColor.black
        textView.font = Constants.Font.fontMedium
        
        return textView
    }()
    
    var taskCompletedView: UIImageView = {
        let taskCompletedImageView = UIImageView()
        taskCompletedImageView.isUserInteractionEnabled = true
        return taskCompletedImageView
    }()
    
    var saveButton: UIButton = {
        let button = ButtonType.system(title: "Save", color: UIColor.black)
        var ui = button.newButton
        ui.setAttributedTitle( NSAttributedString(string: "Save", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: Constants.Font.fontSmall]), for: .normal)
        ui.isHidden = true
        ui.isEnabled = false
        return ui
    }()
}

extension TaskCell {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTextView(label: taskDescriptionLabel)
        configureTextView(label: taskDueLabel)
        configureTextView(label: taskNameLabel)
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Configure cell
    
    func configureTextView(label:UITextView) {
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.isScrollEnabled = false
        label.isEditable = false
        label.isUserInteractionEnabled = false
    }
    
    func configureView(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.nameLabelHeight).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.dueWidth).isActive = true
    }
    
    func configureDesription(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.descriptionBoxHeight).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.descriptionLabelWidth).isActive = true
    }
    
    func configureElements(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.saveButtonRightOffset).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.TaskCell.saveButtonTopOffset).isActive = true
        view.heightAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonHeight).isActive = true
    }
    
    func setupConstraints() {
        configureView(view: taskNameLabel)
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.TaskCell.nameLabelTopOffset).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:Constants.TaskCell.nameLabelLeftOffset).isActive = true
        configureView(view: taskDueLabel)
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:Constants.TaskCell.dueTopOffset).isActive = true
        configureDesription(view: taskDescriptionLabel)
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.TaskCell.descriptionsLabelBottomOffset).isActive = true
        configureElements(view: taskCompletedView)
        taskCompletedView.widthAnchor.constraint(equalToConstant: Constants.TaskCell.completedHeight).isActive = true
        configureElements(view: saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth).isActive = true
        configureDesription(view: taskDescriptionBox)
        taskDescriptionBox.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDescriptionBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.TaskCell.descriptionsLabelBottomOffset).isActive = true
    }
    
    func configureCell(taskVM:TaskCellViewModel, toggled:Bool) {
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        contentView.backgroundColor = UIColor.clear
        
        taskNameLabel.text = taskVM.taskName
        taskDueLabel.text = "Due date: \(taskVM.taskDue)"
        taskDescriptionLabel.text = taskVM.taskDescription
        self.toggled = toggled
        
        saveButton.addTarget(self, action: #selector(toggleForButtonState(sender:)), for: .touchUpInside)
        if taskVM.taskCompleted == "true" {
            taskCompletedView.image = UIImage(named:"checked")
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleForEditState))
            taskCompletedView.addGestureRecognizer(tap)
            saveButton.addTarget(self, action: #selector(toggleForEditState), for: .touchUpInside)
        } else {
            taskCompletedView.image = UIImage(named:"edit")
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleForEditState))
            taskCompletedView.addGestureRecognizer(tap)
        }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
    
}
