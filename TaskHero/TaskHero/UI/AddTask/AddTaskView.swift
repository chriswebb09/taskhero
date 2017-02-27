import UIKit

enum FieldSelected {
    case nameField, descriptionBox
}

final class AddTaskView: UIView {
    
    var taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.text = "Add A New Task"
        taskNameLabel.font = Constants.Font.fontLarge
        taskNameLabel.textAlignment = .center
        taskNameLabel.layer.masksToBounds = true
        return taskNameLabel
    }()
    
    var taskNameField = TextFieldExtension().emailField("Task name") {
        didSet {
            print(taskNameField.text ?? "No text entered")
        }
    }
    
    var taskDescriptionBox: UITextView = {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
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
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.layer.borderWidth = Constants.Border.borderWidth
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.backgroundColor = Constants.Color.buttonColor.setColor
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
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AddTaskViewConstants.widthMultiplier).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: AddTaskViewConstants.heightMultiplier).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setupConstraints() {
        
        configureView(view: taskNameLabel)
        taskNameLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: bounds.height * AddTaskViewConstants.nameLabelTopMultiplier).isActive = true
        configureView(view: taskNameField)
        taskNameField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor,
                                           constant: bounds.height * AddTaskViewConstants.nameLabelTopMultiplier).isActive = true
        
        addSubview(taskDescriptionBox)
        taskDescriptionBox.widthAnchor.constraint(equalTo: widthAnchor,
                                                  multiplier: AddTaskViewConstants.widthMultiplier).isActive = true
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor,
                                                   multiplier: AddTaskViewConstants.descriptionBoxHeightMultiplier).isActive = true
        taskDescriptionBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor, constant: bounds.height * Constants.Dimension.settingsOffset).isActive = true
        
        addSubview(addTaskButton)
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor,
                                             multiplier: AddTaskViewConstants.addTaskButtonWidthMultiplier).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor,
                                              multiplier: AddTaskViewConstants.heightMultiplier).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor, constant: bounds.height *  AddTaskViewConstants.addTaskButtonTopOffset).isActive = true
    }
    
    func animatedPosition() {
        taskNameLabel.isHidden = false
        let selected: FieldSelected = taskNameField.isFirstResponder ? .nameField : .descriptionBox
        switch selected {
        case .nameField:
            taskNameField.layer.borderColor = UIColor.gray.cgColor
        case .descriptionBox:
            taskDescriptionBox.layer.borderColor = UIColor.gray.cgColor
        }
        
        taskNameField.topAnchor.constraint(equalTo: topAnchor,
                                           constant: self.bounds.height * AddTaskViewConstants.taskNameFieldTopMultiplier)
        taskDescriptionBox.heightAnchor.constraint(equalTo: heightAnchor,
                                                   multiplier: AddTaskViewConstants.taskDescriptionBoxHeightMultiplier)
        taskDescriptionBox.topAnchor.constraint(equalTo: taskNameField.bottomAnchor,
                                                constant: self.bounds.height * AddTaskViewConstants.topOffset)
        addTaskButton.topAnchor.constraint(equalTo: taskDescriptionBox.bottomAnchor,
                                           constant: self.bounds.height * AddTaskViewConstants.topOffset)
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}

struct AddTaskViewConstants {
    static let topOffset: CGFloat = 0.02
    static let widthMultiplier: CGFloat = 0.85
    static let heightMultiplier: CGFloat = 0.07
    static let nameLabelTopMultiplier: CGFloat = 0.05
    static let descriptionBoxHeightMultiplier:CGFloat = 0.3
    static let addTaskButtonWidthMultiplier: CGFloat = 0.4
    static let addTaskButtonTopOffset: CGFloat = 0.05
    static let taskNameFieldTopMultiplier: CGFloat = 0.04
    static let taskDescriptionBoxHeightMultiplier: CGFloat = 0.2
}
