//
//  TaskCellTextView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/13/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


import UIKit

extension UITextView {
    
//    func setupEditStyledTextView() -> UITextView {
//        layer.borderWidth = Constants.Dimension.mainWidth
//        layer.borderColor = UIColor.lightGray.cgColor
//        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
//        font = Constants.signupFieldFont
//        contentInset = Constants.TaskCell.Description.boxInset
//        return self
//    }
    
    
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
