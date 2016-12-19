//
//  TaskCell+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

extension TaskCell {
    
    //MARK: - Delegate Methods
    
    // Button toggle methods
    
    func toggle() {
        //toggled = !toggled
        if toggled {
            toggleState()
            taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
        } else {
            toggleState()
            taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
        }
    }
    
    func taskCell(_taskCell:TaskCell, didToggleEditState editState:Bool) {
        if editState {
            taskDescriptionLabel.isHidden = editState
            taskDescriptionBox.isHidden = !editState
            saveButton.isEnabled = editState
            saveButton.isHidden = !editState
            taskCompletedView.isHidden = editState
            taskCompletedView.isUserInteractionEnabled = editState
        }
    }
    
    func toggleState() {
        print(toggled = !toggled)
        taskDescriptionLabel.isHidden = toggled
        taskDescriptionBox.isHidden = !toggled
        saveButton.isEnabled = toggled
        saveButton.isHidden = !toggled
        taskCompletedView.isHidden = toggled
        taskCompletedView.isUserInteractionEnabled = toggled
    }
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        toggle()
        delegate?.toggleForEditState(sender:sender)
       
    }

    func toggleForButtonState(sender:UIButton) {
        toggle()
        delegate?.toggleForButtonState(sender: sender)
    }
}

// taskToggle(taskToggled: toggled!)
//taskToggle(taskToggled: toggled!)
// taskToggle(taskToggled: toggled!)


//    func inactive() {
//        taskDescriptionLabel.isHidden = toggled
//        
//    }
//    
    
    
//    func taskToggle(taskToggled:Bool) {
//        var taskToggled = taskToggled
//        print("Task toggle============")
//        print(taskToggled)
//        print("==================")
//        taskToggled = !toggled!
//        if taskToggled == true {
//            print("toggling for active")
//            toggleForInactive()
//        } else {
//            toggleUIForActive()
//            print("toggling for inactive")
//        }
//    }
//    
//    func toggleUIForActive() {
//        print("toggled active")
//        taskDescriptionLabel.isHidden = true
//        taskDescriptionBox.isHidden = false
//        taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
//        saveButton.isEnabled = true
//        saveButton.isHidden = false
//        taskCompletedView.isHidden = true
//        taskCompletedView.isUserInteractionEnabled = false
//    }
//
//    func toggleForInactive() {
//        print("toggled inactive")
//        toggled = !toggled!
//        taskDescriptionLabel.isHidden = false
//        taskDescriptionBox.isHidden = true
//        taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
//        saveButton.isEnabled = false
//        saveButton.isHidden = true
//        taskCompletedView.isHidden = false
//        taskCompletedView.isUserInteractionEnabled = true
//    }
//    
////    func toggleForEditState(sender:UIGestureRecognizer) {
//        delegate?.toggleForEditState(sender:sender)
//        taskToggle(taskToggled: toggled!)
//       // taskToggle(taskToggled: toggled!)
//    }
    
//    func toggleForButtonState(sender:UIButton) {
//        taskToggle(taskToggled: toggled!)
//        delegate?.toggleForButtonState(sender: sender)
//    }

