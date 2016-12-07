//
//  TaskCell+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

extension TaskCell {
    
    func taskToggle(taskToggled:Bool) {
        print("Task toggle")
        if taskToggled == true {
            print("toggling for active")
            toggleForInactive()
        } else {
            toggleUIForActive()
            print("toggling for inactive")
            
        }
    }
    
    func buttonToggle(buttonToggle:Bool) {
        print("Button toggle")
        if buttonToggled == true {
            print("Button toggled for active")
            toggleUIForActive()
        } else {
            print("Button toggled for inactive")
            toggleForInactive()
        }
    }
    
    func toggleUIForActive() {
        print("toggled active")
        taskDescriptionLabel.isHidden = true
        taskDescriptionBox.isHidden = false
        taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
        saveButton.isEnabled = true
        saveButton.isHidden = false
        taskCompletedView.isHidden = true
        taskCompletedView.isUserInteractionEnabled = false
    }
    
    func toggleForInactive() {
        print("toggled inactive")
        taskDescriptionLabel.isHidden = false
        taskDescriptionBox.isHidden = true
        taskDescriptionBox.layer.borderWidth = Constants.Settings.searchFieldButtonRadius
        saveButton.isEnabled = false
        saveButton.isHidden = true
        taskCompletedView.isHidden = false
        taskCompletedView.isUserInteractionEnabled = true
    }
    
    func toggleForEditState(sender:UIGestureRecognizer) {
        taskToggle(taskToggled: toggled!)
        delegate?.toggleForEditState(sender:sender)
    }
    
    func toggleForButtonState(sender:UIButton) {
        taskToggle(taskToggled: toggled!)
        delegate?.toggleForButtonState(sender: sender)
    }
}
