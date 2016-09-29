//
//  AddTaskViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class AddTaskViewController: UIViewController {
    
    var databaseRef: FIRDatabaseReference!
    let addTaskView = AddTaskView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(addTaskView)
        
        addTaskView.layoutSubviews()
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        
        let backButton = UIBarButtonItem(image:UIImage(named:"back-1"), style: .done, target:self, action: #selector(backTapped))
        
        backButton.title = "Back"
        backButton.tintColor = UIColor.black
        
        navigationItem.leftBarButtonItem = backButton
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        self.databaseRef = FIRDatabase.database().reference(withPath:"users/\(uid)/tasks/")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func addTaskButtonTapped() {
        let uid = NSUUID().uuidString
        let newTask = Task()
        newTask.taskID = uid
        newTask.taskName = addTaskView.taskNameTextField.text!
        newTask.taskDue = "unknown"
        newTask.taskDescription = addTaskView.taskDescriptionTextView.text
        //self.databaseRef?.child("\(uid)/email").setValue(FIRAuth.auth()!.currentUser!.email)
        self.databaseRef?.child("/taskID").setValue(newTask.taskID)
        self.databaseRef?.child("\(newTask.taskID)/taskName").setValue(newTask.taskName)
        self.databaseRef?.child("\(newTask.taskID)/taskDue").setValue(newTask.taskDue)
        self.databaseRef?.child("\(newTask.taskID)/taskDescription").setValue(newTask.taskDescription)
        navigationController?.popToRootViewController(animated: false)
        //self.navigationController?.popToRootViewController(animated: false)
    }
    
    
    func backTapped(sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: false)
       // navigationController?.popViewController(animated: false)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

