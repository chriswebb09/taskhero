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
        self.layer.borderWidth = Constants.Settings.searchButtonWidth
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        self.font = Constants.signupFieldFont
        self.contentInset = Constants.TaskCell.boxInset
        return self
    }
}
