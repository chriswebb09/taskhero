//
//  SignupViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/20/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension SignupViewController {
    
    // Checks text for valid email format and returns bool based on result
    
    func validateEmailInput(email:String, confirm:String) -> Bool {
        let emailLower = email.lowercased()
        let confirmLower = confirm.lowercased()
        if (email.isValidEmail()) && (emailLower == confirmLower) { return true } else { emailInvalidated = true; return false }
    }
    
    // Checks that text has more than five characters / animates UITextField to blue color if true.
    
    func checkTextField(_ textField: UITextField) {
        if (textField.text?.characters.count)! > 5 {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { textField.layer.borderColor = UIColor.blue.cgColor },
                           completion: nil)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension SignupViewController {
    
    // Sets selected textfield to the field below the current one on return key/ if last textfield cycles to top of fields and repeats.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signupView.usernameField {
            let nextField = (textField === signupView.usernameField) ? signupView.emailField : signupView.confirmEmailField
            nextField.becomeFirstResponder()
        } else if textField == signupView.emailField {
            let nextField = (textField === signupView.emailField) ? signupView.confirmEmailField : signupView.passwordField
            nextField.becomeFirstResponder()
        } else if textField == signupView.confirmEmailField {
            let nextField = (textField === signupView.confirmEmailField) ? signupView.passwordField : signupView.usernameField
            nextField.becomeFirstResponder()
        } else if textField == signupView.passwordField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextField(textField)
        if textField == signupView.usernameField {
            print(store.validUsernames)
            if store.validUsernames.contains(signupView.usernameField.text!) {
                signupView.usernameField.layer.borderColor = Constants.Signup.textFieldColor.cgColor
                signupView.usernameField.textColor = Constants.Signup.textFieldColor
                signupView.signupButton.isEnabled = false
            } else if !store.validUsernames.contains(signupView.usernameField.text!) {
                signupView.usernameField.layer.borderColor = Constants.Color.mainColor.cgColor
                signupView.usernameField.textColor = Constants.Color.mainColor
                signupView.signupButton.isEnabled = true
            }
        }
        
        if textField == signupView.emailField {
            if !(textField.text?.isValidEmail())! {
                signupView.emailField.layer.borderColor = Constants.Signup.animationColor.cgColor
                signupView.emailField.textColor = Constants.Signup.animationColor
            }  else if (textField.text?.isValidEmail() )!{
                signupView.emailField.textColor = UIColor.blue
            }
        }
        
        if (validateEmailInput(email: signupView.emailField.text!, confirm: signupView.confirmEmailField.text!)) && (emailInvalidated) {
            signupView.emailField.layer.borderColor = Constants.Signup.invalidColor.cgColor
            signupView.emailField.textColor = Constants.Signup.invalidColor
            signupView.confirmEmailField.layer.borderColor = Constants.Signup.invalidColor.cgColor
            signupView.confirmEmailField.textColor = Constants.Signup.invalidColor
            let when = DispatchTime.now() + 0.9 //
            DispatchQueue.main.asyncAfter(deadline: when) {
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: {
                                self.invalidateStyleFor(field: self.signupView.usernameField)
                                self.invalidateStyleFor(field: self.signupView.emailField)
                                self.invalidateStyleFor(field: self.signupView.confirmEmailField)
                }) } } else if textField == signupView.confirmEmailField {
            if (!validateEmailInput(email: signupView.emailField.text!, confirm: self.signupView.confirmEmailField.text!)) {
                self.setAnimationStyleFor(field: signupView.emailField)
                self.setAnimationStyleFor(field: signupView.confirmEmailField)
            }
        }
    }
    
}

extension SignupViewController {
    
    fileprivate func invalidateStyleFor(field:UITextField) {
        field.layer.borderColor = Constants.Color.mainColor.cgColor
        field.textColor = Constants.Color.mainColor
    }
    
    fileprivate func setAnimationStyleFor(field:UITextField) {
        field.layer.borderColor = Constants.Signup.animationColor.cgColor
        field.textColor = Constants.Signup.animationColor
    }
}
