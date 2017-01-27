//
//  TaskCellTextView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/13/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


import UIKit


class TaskCellView: UIView {
    
    var taskNameLabel: UITextView {
        let textView = UITextView().setupCellStyle()
        return textView
    }
    
    var taskDescriptionLabel: UITextView {
        let textView = UITextView()
        textView.labelTextViewStyle()
        return textView
    }
    
    var taskDueLabel: UITextView {
        let textView = UITextView().setupCellStyle()
        return textView
    }
    
    var taskCompletedView: UIImageView {
        let taskCompletedImageView = UIImageView()
        taskCompletedImageView.isUserInteractionEnabled = true
        return taskCompletedImageView
    }
    
    var saveButton: UIButton {
        let button = ButtonType.system(title: "Save", color: UIColor.black).newButton
        button.setAttributedTitle(NSAttributedString(string: "Save", attributes: [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: Constants.Font.fontSmall]), for: .normal)
        button.isHidden = true
        button.isEnabled = false
        return button
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupConstraints() {
        
    }
}


extension UITextView {
    
    func editTextViewStyle() {
        print("Inside edit text view style")
        layer.borderWidth = Constants.Dimension.mainWidth
        backgroundColor = UIColor.white
        textColor = UIColor.black
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        font = Constants.signupFieldFont
        contentInset = Constants.TaskCell.Description.boxInset
    }
    
    func labelTextViewStyle() {
        backgroundColor = Constants.TaskCell.Description.descriptionLabelBackgroundColor
        font = Constants.Font.fontMedium
        textColor = UIColor.white
        isEditable = false
        isSelectable = false
        isUserInteractionEnabled = false
    }
}
