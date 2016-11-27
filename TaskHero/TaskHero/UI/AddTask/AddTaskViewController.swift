//
//  AddTaskViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class AddTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
   

    
    let store = DataStore.sharedInstance
    let alert = AlertPopover()
    let addTaskView = AddTaskView()
    let pop = PopMenu()
    var pickerMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    //CGRect(y)
    let pick = UIPickerView(frame: CGRect(x:0, y:200, width:300, height:300))
    //let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addTaskView)
        navigationController?.navigationBar.tintColor = UIColor.white
        edgesForExtendedLayout = []
        addTaskView.layoutSubviews()
        pick.dataSource = self
        pick.dataSource = self
       // picker.delegate = self
        //picker.delegate = self
        addTaskView.taskNameField.delegate = self
        addTaskView.taskDescriptionBox.delegate = self
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}

extension AddTaskViewController {
  

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        if(replacementText.isEqual("\n")) {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe what you want to get done."
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension AddTaskViewController {
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        pop.popView.isHidden = false
//        pop.showPopView(viewController: self)
//        pop.popView.layer.borderWidth = 1
//        pop.popView.layer.borderColor = UIColor.black.cgColor
//        pop.popView.layer.shadowOffset = CGSize(width:-0.5, height: 0.3)
//        pop.popView.layer.shadowOpacity = 0.1
//        label.text = settings[indexPath.row]
//        label.sizeToFit()
//        pop.popView.addSubview(label)
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideView))
//        pop.containerView.addGestureRecognizer(tap)
//    }
//    
//    func hideView() {
//        label.text = ""
//        pop.popView.isHidden = true
//        pop.hidePopView(viewController: self)
//    }
    
    
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//    
  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        
//        return pickerData[row]
//    }
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        
//        return 4
//    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerMonths.count
        } else if component == 1 {
            return 30
        } else {
            return 3
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerMonths[row]
        } else if component == 1 {
            let range: [Int] = Array(1...30)
            
            return String(describing: range[row])
        } else {
            var years = ["2016", "2017", "2018"]
            return years[row]
        }
        
    }
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var pickerData = ["one", "two"]
//        //pickerView.
//        //myLabel.text = pickerData[row]
//    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return "Row"
//    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        //pick.view(forRow: row, forComponent: int).backgorun
//        return pickerData[row]
//    }
    
    func addTaskButtonTapped() {
        pop.popView.isHidden = false
        
        view.endEditing(true)
        let uid = NSUUID().uuidString
        guard let taskName = addTaskView.taskNameField.text else { return }
        guard let taskDescription = addTaskView.taskDescriptionBox.text else { return }
//        
//        picker.frame = CGRect(x:100, y:100, width:100, height:162)
//        picker.backgroundColor = UIColor.black
//        picker.layer.borderColor = UIColor.white.cgColor
        
        // var newPick = UIPickerView()
        // alert.popView.addSubview(newPick)
        //alert.showPopView(viewController: self)
        // var picker = UIPickerView()
        //pop.popView.picker.dataSource = self
        //pop.popView.picker.delegate = self
        
       // pick.
       // pick.inputView =
        pick.showsSelectionIndicator = true
        
        pick.frame = pop.popView.frame
        //pick.
        //pick.layer.borderColor = UIColor.blue.cgColor
        pick.layer.borderWidth = 1
        
        //pick.numberOfComponents = 1
        //pick.numberOfRows(inComponent: 8)
        pop.showPopView(viewController: self, pick: pick)
        
        let newTask = Task(taskID: uid, taskName: taskName, taskDescription: taskDescription, taskCreated:NSDate().dateWithFormat(), taskDue:NSDate().dateWithFormat(), taskCompleted: false, pointValue:5)
        store.addTasks(task: newTask)
        self.store.tasks.append(newTask)
       // _ = navigationController?.popToRootViewController(animated: false)
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // func backTapped(sender: UIBarButtonItem) {
    //    _ = navigationController?.popToRootViewController(animated: false)
    // }
}
