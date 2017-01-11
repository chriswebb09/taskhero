//
//  UITextView+Extensions.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/20/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UITextView {
    func setupStyledTextView() -> UITextView {
        layer.borderWidth = Constants.Dimension.mainWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        font = Constants.signupFieldFont
        contentInset = Constants.TaskCell.Description.boxInset
        return self
    }
}
