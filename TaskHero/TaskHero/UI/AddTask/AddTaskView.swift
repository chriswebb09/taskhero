import UIKit

enum FieldSelected {
    case nameField, descriptionBox
}

final class AddTaskView: UIView {
    
    var taskNameLabel: UILabel = {
        let taskNameLabel = UILabel.centerLabel(textColor: .black, font: Constants.Font.fontLarge)
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskNameLabel
    }()
    
    var taskNameField = TextFieldExtension().emailField("Task name") {
        didSet {
            print(taskNameField.text ?? "No text entered")
        }
    }
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView.textBox(placeholderText: "Describe what you want to get done.")
        return taskDescriptionBox
    }()
  
    var addTaskButton: UIButton = {
        var taskButton = UIButton.taskButton()
        return taskButton
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
    
    fileprivate func configureView(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AddTaskViewConstants.widthMultiplier).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AddTaskViewConstants.heightMultiplier).isActive = true
    }
    
    fileprivate func setupConstraints() {
        let boxTopOffset = bounds.height * Constants.Dimension.settingsOffset
        let topNameLabel = bounds.height * AddTaskViewConstants.nameLabelTopMultiplier
        let buttonTopOffset = bounds.height * AddTaskViewConstants.addTaskButtonTopOffset
        
        configureView(view: taskNameLabel)
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: topNameLabel).isActive = true
        
        configureView(view: taskNameField)
        taskNameField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: topNameLabel).isActive = true
        
        addSubview(taskDescriptionBox)
        taskDescriptionBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: boxTopOffset).isActive = true
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AddTaskViewConstants.widthMultiplier).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AddTaskViewConstants.descriptionBoxHeightMultiplier).isActive = true
        
        addSubview(addTaskButton)
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: buttonTopOffset).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AddTaskViewConstants.heightMultiplier).isActive = true
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AddTaskViewConstants.addTaskButtonWidthMultiplier).isActive = true
    }
    
    func animatedPosition() {
        
        let buttonTop = bounds.height * AddTaskViewConstants.topOffset
        let descriptionBoxTop = bounds.height * AddTaskViewConstants.topOffset
        let taskNameFieldTop = bounds.height * AddTaskViewConstants.taskNameFieldTopMultiplier
        let selected: FieldSelected = taskNameField.isFirstResponder ? .nameField : .descriptionBox
        
        taskNameLabel.isHidden = false
        
        switch selected {
        case .nameField:
            taskNameField.layer.borderColor = UIColor.gray.cgColor
        case .descriptionBox:
            taskDescriptionBox.layer.borderColor = UIColor.gray.cgColor
        }
        
        taskNameField.topAnchor.constraint(equalTo: topAnchor, constant: taskNameFieldTop)
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AddTaskViewConstants.taskDescriptionBoxHeightMultiplier)
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: descriptionBoxTop)
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: buttonTop)
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}
