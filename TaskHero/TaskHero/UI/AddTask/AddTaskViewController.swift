//
//  AddTaskViewController.swift
//  TaskHero
//

import UIKit
import Firebase

final class AddTaskViewController: UIViewController  {
    
    let store = UserDataStore.sharedInstance /* User state for application */
    
    let addTaskView = AddTaskView()
    var addTaskViewModel = AddTaskViewModel()
    
    let pop = PopMenu()
    let pick = UIPickerView(frame: CGRect(x:0, y:200, width:290, height:290))
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addTaskView)
        pick.layer.borderColor = UIColor.clear.cgColor
        commonInit()
        setUIInteraction()
    }
    
    private func commonInit() {
        setupPick()
        setupDelegates()
        addTaskView.layoutSubviews()
        edgesForExtendedLayout = []
    }
    
    func setUIInteraction() {
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - TextField Methods

extension AddTaskViewController: UITextFieldDelegate, UITextViewDelegate {
    
    /* Adds UITextFieldDelegate and UITextViewDelege to AddTaskViewController */
    
    func setupDelegates() {
        addTaskView.taskNameField.delegate = self
        addTaskView.taskDescriptionBox.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.addTaskView.animatedPostion()
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.placeholder = "Task name"
        }
    }
}

extension AddTaskViewController {
    
    /* On return-key press hides keyboard */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* If textfield input is equal to newline - return - hides keyboard */
    
    func textView(_ textView: UITextView, shouldChangeTextIn shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        let shouldChangeText: Bool = replacementText.isEqual("\n")
        if shouldChangeText { textView.resignFirstResponder() }
        return !shouldChangeText
    }
    
    /* If user is done editting && user has not entered anything - sets taskdescription box default text */
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe what you want to get done."
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Describe what you want to get done." {
            textView.text = ""
            textView.textColor = .black
        }
    }
}

/* MARK: - Extension UIPickerView Methods */

extension AddTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func setupPick() {
        pick.dataSource = self
    }
    
    /* 3 components in picker - day - month - year */
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return addTaskViewModel.numberOfComponents
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var type: ComponentType = (component == 0) ? .months : .days
        
        if component >= 2 {
            type = .years
        }
        
        switch type {
        case .months:
            return addTaskViewModel.pickerMonths.count
        case .days:
            return 30
        case .years:
            return 3
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var type: ComponentType = (component == 0) ? .months : .days
        
        if component >= 2 {
            type = .years
        }
        switch type {
        case .months:
            return addTaskViewModel.pickerMonths[row]
        case .days:
            var dayString = String(describing: addTaskViewModel.range[row])
            
            if dayString.characters.count < 2 {
                addTaskViewModel.day = "0\(dayString)"
            }
            
            return addTaskViewModel.day
        case .years:
            return addTaskViewModel.years[row]
        }
    }
    
    /* Sets UIPickerView data */
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var type: ComponentType = (component == 0) ? .months : .days
        
        if component >= 2 {
            type = .years
        }
        switch type {
        case .months:
            addTaskViewModel.month = String(describing:addTaskViewModel.pickerMonths[row])
        case .days:
            addTaskViewModel.day = String(describing: addTaskViewModel.range[row])
        case .years:
            addTaskViewModel.year = addTaskViewModel.years[row]
        }
    }
    
    /* When add task button pressed - data popover is show so user can pick task due data */
    
    dynamic fileprivate func addTaskButtonTapped() {
        view.endEditing(true)
        DispatchQueue.main.async { self.changePopViewUI() }
        pop.popupView.button.addTarget(self, action: #selector(formatTaskWithDate), for: .touchUpInside)
    }
    
    func changePopViewUI() {
        self.pop.popView.isHidden = false
        self.pick.showsSelectionIndicator = true
        self.pick.frame = self.pop.popView.frame
        self.pick.layer.borderWidth = 1
        self.pop.showPopView(viewController: self, pick: self.pick)
    }
    
    /* Formats user input into task object using the chosen due date and sends it to database - hides datepopover and return to previous view controller on completion */
    dynamic fileprivate func formatTaskWithDate() {
        
        let uid = UUID.init()
        
        guard let taskName = addTaskView.taskNameField.text else { return }
        guard let taskDescription = addTaskView.taskDescriptionBox.text else { return }
        
        let newTask = Task(taskID: uid.uuidString,
                           taskName: taskName,
                           taskDescription: taskDescription,
                           taskCreated:Date().dateStringFormatted(),
                           taskDue:addTaskViewModel.stringDate,
                           taskCompleted: false,
                           pointValue:5)
        
        store.firebaseAPI.addTasks(task: newTask)
        store.currentUser.tasks!.append(newTask)
        
        DispatchQueue.main.async {
            self.pop.hidePopView(viewController: self)
            
            self.pop.popView.isHidden = true
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    /* Hides keyboard */
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
