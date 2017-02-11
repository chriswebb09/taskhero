//
//  TaskCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TaskCellDelegate: class {
    func toggleForEditState(_ sender:UIGestureRecognizer)
    func toggleForButtonState(_ sender:UIButton)
}

final class TaskCell: UITableViewCell, Toggable {
    // MARK: - Properties
    
    static let cellIdentifier = "TaskCell"
    weak var delegate: TaskCellDelegate?
    var taskViewModel: TaskCellViewModel!
    var toggled: Bool = false
    
    // MARK: - Setup UI Elements
    
    var taskNameLabel: UITextView = {
        let textView = UITextView().setupCellStyle()
        textView.font = UIFont(name: "PingFangTC-Medium", size: 20)
        return textView
    }()
    
    var taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.labelTextViewStyle()
        textView.font = UIFont(name: "PingFangHK-Regular", size: 18)
        //textView.font = Constants.Font.bolderFontNormal
        
        return textView
    }()
    
    var taskDueLabel: UITextView = {
        let textView = UITextView().setupCellStyle()
        return textView
    }()
    
    var taskCompletedView: UIImageView = {
        let taskCompletedImageView = UIImageView()
        taskCompletedImageView.isUserInteractionEnabled = true
        return taskCompletedImageView
    }()
    
    var saveButton: UIButton = {
        let button = ButtonType.system(title: "Save", color: UIColor.black).newButton
        button.setAttributedTitle(NSAttributedString(string: "Save", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: Constants.Font.fontSmall]), for: .normal)
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        setupConfigures()
        contentView.layer.masksToBounds = true
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        contentView.backgroundColor = UIColor.clear
        setupShadow()
    }
}

extension TaskCell {
    
    // MARK: - Configure cell
    
    fileprivate func setupConfigures() {
        configureTextView(label: taskDescriptionLabel)
        configureTextView(label: taskDueLabel)
        configureTextView(label: taskNameLabel)
        setupConstraints()
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
    
    // MARK: - Delegate Methods
    /* Button toggle methods changes taskcell UI based on editState value */
    
    func taskCell(didToggleEditState editState:Bool) {
        textViewToggle(state: editState, textView: taskDescriptionLabel)
    }
    
    func textViewToggle(state: Bool, textView: UITextView) {
        if state == true {
            textView.editTextViewStyle()
            textView.isEditable = true
            textView.isUserInteractionEnabled = true
            saveButton.isEnabled = true
            saveButton.isHidden = false
            taskCompletedView.isHidden = true
            taskCompletedView.isUserInteractionEnabled = false
        } else if state == false {
            textView.labelTextViewStyle()
            textView.isEditable = false
            textView.isUserInteractionEnabled = false
            saveButton.isEnabled = false
            saveButton.isHidden = true
            taskCompletedView.isHidden = false
            taskCompletedView.isUserInteractionEnabled = true
        }
    }
    
    /* taskcompletedview delegate method */
    
    func toggleForEditState(sender: UIGestureRecognizer) {
        toggled = toggleState(state: toggled)
        delegate?.toggleForEditState(sender)
    }
    
    /* Button delegate method */
    
    func toggleForButtonState(sender: UIButton) {
        toggled = toggleState(state: toggled)
        delegate?.toggleForButtonState(sender)
    }
    
    func toggleState(state: Bool) -> Bool {
        let toggleState = !state
        taskCell(didToggleEditState: toggleState)
        return toggleState
    }
    
    // MARK: - Configure cell subviews
    /* Takes in textview returns configured textview*/
    
    func configureTextView(label: UITextView) {
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.isScrollEnabled = false
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.layer.cornerRadius = Constants.TaskCell.Shadow.cornerRadius
    }
    
    /* Sets up taskNameLabel and taskDue label top, right and height constraints */
    
    func configureView(view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.nameLabelHeight).isActive = true
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.dueWidth).isActive = true
    }
    
    /* TaskDescription label configuration */
    
    func setupDescriptionElements(element: UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.TaskCell.Description.descriptionBoxHeight).isActive = true
        element.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.TaskCell.Description.descriptionLabelWidth).isActive = true
        element.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Dimension.bottomOffset).isActive = true
        element.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    /* TaskCompletedview and savebutton configuration */
    
    func setupEditElements(element: UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.TaskCell.negativeOffset).isActive = true
        element.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.mainOffset).isActive = true
        element.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * Constants.Dimension.saveButtonHeight).isActive = true
    }
    
    func addTaskNameLabel(taskNameLabel: UITextView) {
        configureView(view: taskNameLabel)
        print(contentView.frame.height * 0.2)
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height * 0.35).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:contentView.bounds.width * 0.02).isActive = true
    }
    
    func addTaskDueLabel(taskDueLabel: UITextView) {
        configureView(view: taskDueLabel)
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width * 0.02).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: contentView.bounds.height * 0.06).isActive = true
    }
    
    func setupConstraints() {
        addTaskNameLabel(taskNameLabel:taskNameLabel)
        addTaskDueLabel(taskDueLabel: taskDueLabel)
        setupDescriptionElements(element: taskDescriptionLabel)
        setupEditElements(element: taskCompletedView)
        taskCompletedView.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth * 0.5).isActive = true
        setupEditElements(element:saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: Constants.TaskCell.saveButtonWidth).isActive = true
    }
    
    func setupShadow() {
        let shadowOffset = CGSize(width:-0.45, height: 0.2)
        let shadowRadius:CGFloat = 1.0
        let shadowOpacity:Float = 0.4
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
    
    /* Methods used in VC to setup cell with data */
    
    func configureCell(taskVM: TaskCellViewModel) {
        layoutSubviews()
        taskNameLabel.text = taskVM.taskName
        taskDueLabel.text = "Due date: \(taskVM.taskDue)"
        taskDescriptionLabel.text = taskVM.taskDescription
        saveButton.addTarget(self, action: #selector(toggleForButtonState(sender:)), for: .touchUpInside)
        NSLog(self.description)
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
