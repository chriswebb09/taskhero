//
//  UITextView+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UITextView {
    
    class func textBox(placeholderText: String) -> UITextView {
        let taskDescriptionBox = UITextView()
        taskDescriptionBox.textColor = .lightGray
        taskDescriptionBox.font = Constants.signupFieldFont
        taskDescriptionBox.text = placeholderText
        taskDescriptionBox.layer.borderColor = UIColor.lightGray.cgColor
        taskDescriptionBox.layer.borderWidth = Constants.Border.borderWidth
        taskDescriptionBox.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionBox.contentInset = Constants.TaskCell.Description.boxInset
        taskDescriptionBox.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        return taskDescriptionBox
    }
}
