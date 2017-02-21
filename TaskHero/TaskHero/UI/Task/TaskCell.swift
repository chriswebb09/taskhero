import UIKit
import SnapKit

protocol TaskCellDelegate: class {
    func toggleForEditState(_ sender:UIGestureRecognizer)
    func toggleForButtonState(_ sender:UIButton)
}

final class TaskCell: UITableViewCell, Toggable {
    
    static let cellIdentifier = "TaskCell"
    weak var delegate: TaskCellDelegate?
    var taskViewModel: TaskCellViewModel!
    var toggled: Bool = false
    
    var taskNameLabel: UITextView = {
        let textView = UITextView().setupCellStyle()
        textView.font = Constants.Font.bolderFontNormal
        return textView
    }()
    
    var taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.labelTextViewStyle()
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
    
    private func setupConfigures() {
        configureTextView(label: taskDescriptionLabel)
        configureTextView(label: taskDueLabel)
        configureTextView(label: taskNameLabel)
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
    
    // MARK: - Delegate Methods
    /* Button toggle methods - changes taskCell UI based on editstate value */
    
    func taskCell(didToggleEditState editState:Bool) {
        textViewToggle(state: editState, textView: taskDescriptionLabel)
    }
    
    func textViewToggle(state: Bool, textView: UITextView) {
        if state == true {
            textView.editTextViewStyle()
        } else if state == false {
            textView.labelTextViewStyle()
        }
        textView.isEditable = state
        textView.isUserInteractionEnabled = state
        saveButton.isEnabled = state
        saveButton.isHidden = !state
        taskCompletedView.isHidden = state
        taskCompletedView.isUserInteractionEnabled = !state
    }
    
    /* taskCompletedView delegate method */
    
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
    /*  takes in textview returns configured textview */
    
    func configureTextView(label: UITextView) {
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.isScrollEnabled = false
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.layer.cornerRadius = Constants.TaskCell.Shadow.cornerRadius
    }
    
    /* sets up taskNameLabel and taskDue label top, right and height constraints */
    
    func configureView(view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.TaskCell.nameLabelHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.TaskCell.dueWidth)
        }
    }
    
    /* taskDescription label configuration */
    
    func setupDescriptionElements(element: UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.TaskCell.Description.descriptionBoxHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.TaskCell.Description.descriptionLabelWidth)
            make.bottom.equalTo(contentView.snp.bottom).offset(Constants.Dimension.bottomOffset)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    /* taskCompletedView and saveButton configuration */
    
    func setupEditElements(element: UIView) {
        contentView.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(Constants.TaskCell.negativeOffset)
            make.top.equalTo(contentView.snp.top).offset(Constants.Dimension.mainOffset)
            make.height.equalTo(UIScreen.main.bounds.height * Constants.Dimension.saveButtonHeight)
        }
    }
    
    func addTaskNameLabel(taskNameLabel: UITextView) {
        configureView(view: taskNameLabel)
        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.Dimension.topOffset)
            make.left.equalTo(contentView.snp.left).offset(Constants.TaskCell.nameLabelLeftOffset)
        }
    }
    
    func addTaskDueLabel(taskDueLabel: UITextView) {
        configureView(view: taskDueLabel)
        taskDueLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top).offset(Constants.TaskCell.dueTopOffset)
        }
    }
    
    func setupConstraints() {
        addTaskNameLabel(taskNameLabel:taskNameLabel)
        addTaskDueLabel(taskDueLabel: taskDueLabel)
        setupDescriptionElements(element: taskDescriptionLabel)
        setupEditElements(element: taskCompletedView)
        taskCompletedView.snp.makeConstraints { make in
            make.width.equalTo(Constants.TaskCell.saveButtonWidth * 0.5)
        }
        setupEditElements(element:saveButton)
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(Constants.TaskCell.saveButtonWidth)
        }
    }
    
    func setupShadow() {
        let shadowOffset = CGSize(width:-0.45, height: 0.2)
        let shadowRadius:CGFloat = 1.0
        let shadowOpacity:Float = 0.4
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
    
    func configureCell(taskVM: TaskCellViewModel) {
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
