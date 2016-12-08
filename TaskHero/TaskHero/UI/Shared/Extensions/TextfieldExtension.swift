//
//  UITextfield+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/21/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TextFieldExtension: UITextField {
    
    // Sets textfield input to + 10 inset on origin x value
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    
    func returnTextField(placeholder:String) -> TextFieldExtension {
        let confirmEmailField = TextFieldExtension()
        confirmEmailField.placeholder = placeholder
        confirmEmailField.font = Constants.signupFieldFont
        confirmEmailField.layer.borderColor = Constants.signupFieldColor
        confirmEmailField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        confirmEmailField.keyboardType = .default
        return confirmEmailField
    }
    
    func emailField(placeholder:String) -> TextFieldExtension {
        let confirmEmailField = TextFieldExtension()
        confirmEmailField.placeholder = placeholder
        confirmEmailField.font = Constants.signupFieldFont
        confirmEmailField.layer.borderColor = Constants.signupFieldColor
        confirmEmailField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        confirmEmailField.keyboardType = .emailAddress
        return confirmEmailField
    }
    
    func passwordField() -> TextFieldExtension {
        let passwordField = TextFieldExtension()
        passwordField.placeholder = "Enter password"
        passwordField.font = Constants.signupFieldFont
        passwordField.layer.borderColor = Constants.signupFieldColor
        passwordField.layer.borderWidth = Constants.Settings.profileSearchButtonBorderWidth
        passwordField.isSecureTextEntry = true
        return passwordField
    }
}
