//
//  TaskCell+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

extension TaskCell: Toggable {
    
    
    // MARK: - Delegate Methods
    
    // Button toggle methods
    
    
    /* changes taskcell UI based on editstate value */
    
    func taskCell(didToggleEditState editState:Bool) {
        textViewToggle(state: editState, textView: taskDescriptionLabel)
    }
    
    
    
    func textViewToggle(state: Bool, textView: UITextView) {
        if state == true {
            textView.editTextViewStyle()
            textView.isEditable = true
            textView.isUserInteractionEnabled = true
            self.saveButton.isEnabled = true
            self.saveButton.isHidden = false
            self.taskCompletedView.isHidden = true
            self.taskCompletedView.isUserInteractionEnabled = false
        } else if state == false {
            textView.labelTextViewStyle()
            textView.isEditable = false
            textView.isUserInteractionEnabled = false
            self.saveButton.isEnabled = false
            self.saveButton.isHidden = true
            self.taskCompletedView.isHidden = false
            self.taskCompletedView.isUserInteractionEnabled = true
        }
    }
    
    /* taskcompletedview delegate method */
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        toggled = toggleState(state: toggled)
        delegate?.toggleForEditState(sender)
    }
    
    /* Button delegate method */
    
    func toggleForButtonState(sender:UIButton) {
        toggled = toggleState(state: toggled)
        delegate?.toggleForButtonState(sender)
    }
    
    func toggleState(state: Bool) -> Bool {
        let toggleState = !state
        taskCell(didToggleEditState: toggleState)
        return toggleState
    }
    
}

extension TaskCell {
    
    // MARK: - Configure cell subviews
    
    /* takes in textview returns configured textview*/
    
    func configureTextView(label:UITextView) {
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.isScrollEnabled = false
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.layer.cornerRadius = Constants.TaskCell.Shadow.cornerRadius
    }
    
    /* sets up taskNameLabel and taskDue label top, right and height constraints */
    
    func configureView(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.nameLabelHeight).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.dueWidth).isActive = true
    }
    
    /* taskdescription label configuration */
    
    func setupDescriptionElements(element:UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.Description.descriptionBoxHeight).isActive = true
        element.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.Description.descriptionLabelWidth).isActive = true
        element.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Dimension.bottomOffset).isActive = true
        element.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    
    /* taskcompletedview and savebutton configuration */
    
    func setupEditElements(element:UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.negativeOffset).isActive = true
        element.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.mainOffset).isActive = true
        element.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * Constants.Dimension.saveButtonHeight).isActive = true
    }
    
    func setupConstraints() {
        
        configureView(view: taskNameLabel)
        print(contentView.frame.height * 0.2)
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.topOffset).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:Constants.TaskCell.nameLabelLeftOffset).isActive = true
        
        configureView(view: taskDueLabel)
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:Constants.TaskCell.dueTopOffset).isActive = true
        
        
        setupDescriptionElements(element: taskDescriptionLabel)
        setupEditElements(element: taskCompletedView)
        taskCompletedView.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth * 0.5).isActive = true
        setupEditElements(element:saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth).isActive = true
    }
    
    
    /* methods used in VC to setup cell with data */
    
    public func configureCell(taskVM:TaskCellViewModel) {
        
        layoutSubviews()
        taskNameLabel.text = taskVM.taskName
        taskDueLabel.text = "Due date: \(taskVM.taskDue)"
        taskDescriptionLabel.text = taskVM.taskDescription
        
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
    
}


