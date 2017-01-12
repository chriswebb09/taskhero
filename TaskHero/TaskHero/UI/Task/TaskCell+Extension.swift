//
//  TaskCell+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

extension TaskCell {
    
    // ===============================
    //MARK: - Delegate Methods
    // ===============================
    
    // Button toggle methods
    
    
    /* changes taskcell UI based on editstate value */
    
    func taskCell(didToggleEditState editState:Bool) {
        toggled = editState
        taskDescriptionLabel.isHidden = toggled
        taskDescriptionBox.isHidden = !toggled
        saveButton.isEnabled = toggled
        saveButton.isHidden = !toggled
        taskCompletedView.isHidden = toggled
        taskCompletedView.isUserInteractionEnabled = toggled
        toggled = !editState
    }
    
    /* taskcompletedview delegate method */
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        taskCell(didToggleEditState: !toggled)
        delegate?.toggleForEditState(sender)
    }
    
    /* Button delegate method */
    
    func toggleForButtonState(sender:UIButton) {
        taskCell(didToggleEditState: toggled)
        delegate?.toggleForButtonState(sender)
    }
}

extension TaskCell {
    
    // =====================================
    // MARK: - Configure cell subviews
    // =====================================
    
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
    func configureDesription(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.Description.descriptionBoxHeight).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.Description.descriptionLabelWidth).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Dimension.bottomOffset).isActive = true
        view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    
    /* taskcompletedview and savebutton configuration */
    func configureElements(view:UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.negativeOffset).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.mainOffset).isActive = true
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * Constants.Dimension.cellButtonHeight).isActive = true
    }
    
    func setupConstraints() {
        configureView(view: taskNameLabel)
        print(contentView.frame.height * 0.2)
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.topOffset).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:Constants.TaskCell.nameLabelLeftOffset).isActive = true
        configureView(view: taskDueLabel)
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:Constants.TaskCell.dueTopOffset).isActive = true
        configureDesription(view: taskDescriptionLabel)
        configureElements(view: taskCompletedView)
        taskCompletedView.widthAnchor.constraint(equalToConstant: Constants.TaskCell.mainHeight).isActive = true
        configureElements(view: saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth).isActive = true
        configureDesription(view: taskDescriptionBox)
    }
    
    /* adds shadow styling to cell */
    
    func setupCellView(width: CGFloat, height: CGFloat) {
        let cellView : UIView = UIView(frame: CGRect(x:0, y:1, width:width, height:height))
        cellView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = Constants.TaskCell.Shadow.cornerRadius
        cellView.layer.shadowOffset = Constants.TaskCell.Shadow.shadowOffset
        cellView.layer.shadowOpacity = Constants.TaskCell.Shadow.styledShadowOpacity
        contentView.addSubview(cellView)
        contentView.sendSubview(toBack: cellView)
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


