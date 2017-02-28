//
//  UIButton+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func taskButton() -> UIButton {
        let addTaskButton = UIButton()
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(.white, for: .normal)
        addTaskButton.layer.borderColor = UIColor.white.cgColor
        addTaskButton.layer.borderWidth = Constants.Border.borderWidth
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.backgroundColor = Constants.Color.buttonColor.setColor
        addTaskButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        return addTaskButton
    }
}
