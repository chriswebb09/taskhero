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

final class TaskCell: UITableViewCell {
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
        let taskDescriptionBox = UITextView().setupStyledTextView()
        taskDescriptionBox.isHidden = true
        return taskDescriptionBox
    }()
    
    let taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Constants.TaskCell.descriptionLabelBackgroundColor
        textView.font = Constants.Font.fontMedium
        textView.textColor = UIColor.white
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
        ui.setAttributedTitle(NSAttributedString(string: "Save", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: Constants.Font.fontSmall]), for: .normal)
        ui.isHidden = true
        ui.isEnabled = false
        return ui
    }()
}

extension TaskCell {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConfigures()
        contentView.layer.masksToBounds = true
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        contentView.backgroundColor = UIColor.clear
    }
    
    // MARK: - Configure cell
    
    fileprivate func setupConfigures() {
        configureTextView(label: taskDescriptionLabel)
        configureTextView(label: taskDueLabel)
        configureTextView(label: taskNameLabel)
        setupConstraints()
    }
    
   func configureCell(taskVM:TaskCellViewModel, toggled:Bool) {
        layoutSubviews()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
}
