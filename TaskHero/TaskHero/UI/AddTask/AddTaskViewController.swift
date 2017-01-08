//
//  AddTaskViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class AddTaskViewController: UIViewController  {
    
    // =============================
    // MARK: Internal Properties
    // =============================
    
    
    let store = DataStore.sharedInstance
    
    let addTaskView = AddTaskView()
    let pop = PopMenu()
    var stringDate = ""
    var month: String = "Jan"
    var day: String = "01"
    var year: String = "2016"
    var taskViewModel = AddTaskViewModel()
    let pick = UIPickerView(frame: CGRect(x:0, y:200, width:300, height:300))
}

extension AddTaskViewController: UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource  {
    
    // =============================
    // MARK: Initialization
    // =============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addTaskView)
        navigationController?.navigationBar.tintColor = UIColor.white
        edgesForExtendedLayout = []
        addTaskView.layoutSubviews()
        pick.dataSource = self
        addTaskView.taskNameField.delegate = self
        addTaskView.taskDescriptionBox.delegate = self
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension AddTaskViewController {
    
    // =================================
    // MARK: TextField Methods
    // =================================
    
    // On return-key press hides keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* If textfield input is equal to newline - return - hides keyboard */
    
    func textView(_ textView: UITextView, shouldChangeTextIn shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        if(replacementText.isEqual("\n")) {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /* If user is done editting && user has not entered anything - sets taskdescription box default text */
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            DispatchQueue.main.async {
                textView.text = "Describe what you want to get done."
                textView.textColor = UIColor.lightGray
            }
        }
    }
}

extension AddTaskViewController: UIPickerViewDelegate {
    
    // =========================================
    // MARK: Extension - UIPickerView Methods
    // =========================================
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return picker options for number of months if at index 0
        if component == 0 {
            return taskViewModel.pickerMonths.count
            // Return numbers of days in month
        } else if component == 1 {
            return 30
            // Return years
        } else {
            return 3
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return taskViewModel.pickerMonths[row]
        } else if component == 1 {
            var dayString = String(describing: taskViewModel.range[row])
            if dayString.characters.count < 2 {
                day = "0\(dayString)"
            }
            return day
        } else {
            return taskViewModel.years[row]
        }
    }
    
    // Sets UIPickerView data
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.month = String(describing:taskViewModel.pickerMonths[row])
        } else if component == 1 {
            self.day = String(describing: taskViewModel.range[row])
        } else {
            self.year = taskViewModel.years[row]
        }
    }
}

extension AddTaskViewController {
    
    
    // ==========================
    // MARK: Public methods
    // ==========================
    
    /* When add task button pressed - data popover is show so user can pick task due data */
    
    @objc fileprivate func addTaskButtonTapped() {
        view.endEditing(true)
        DispatchQueue.main.async {
            self.pop.popView.isHidden = false
            self.pick.showsSelectionIndicator = true
            self.pick.frame = self.pop.popView.frame
            self.pick.layer.borderWidth = 1
            self.pop.showPopView(viewController: self, pick: self.pick)
            self.stringDate = "\(self.month)-\(self.day)-\(self.year)"
        }
        pop.popView.button.addTarget(self, action: #selector(formatTaskWithDate), for: .touchUpInside)
    }
    
    
    /* Formats user input into task object using the chosen due date and sends it to database - hides datepopover and return to previous view controller on completion */
    
    func formatTaskWithDate() {
        let newDate = "\(month)-\(day)-\(year)"
        let uid = NSUUID().uuidString
        guard let taskName = addTaskView.taskNameField.text else { return }
        guard let taskDescription = addTaskView.taskDescriptionBox.text else { return }
        let newTask = Task(taskID: uid, taskName: taskName, taskDescription: taskDescription, taskCreated:NSDate().dateWithFormat(), taskDue:newDate, taskCompleted: false, pointValue:5)
        store.firebaseAPI.addTasks(task: newTask)
        store.currentUser.tasks!.append(newTask)
        DispatchQueue.main.async {
            self.pop.hidePopView(viewController: self)
            self.pop.popView.isHidden = true
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
