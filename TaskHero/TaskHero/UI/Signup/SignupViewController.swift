//
//  SignupViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

final class SignupViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let store = UserDataStore.sharedInstance
    let signupView = SignupView()
    var emailInvalidated = false
    let CharacterLimit = 11
    let helpers = Helpers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        setupSignupView()
        signupView.signupButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    fileprivate func setupSignupView() {
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.confirmEmailField.delegate = self
        signupView.usernameField.delegate = self
        signupView.passwordField.delegate = self
    }
    
    // MARK: - UITextfield Delegate Methods
    // Checks for character length (implemented for username length) if characters exceed allowed range, text field will no longer except new characters
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        if textField == signupView.usernameField {
            if let userName = signupView.usernameField.text {
                let userNameString = userName as NSString
                let updatedText = userNameString.replacingCharacters(in: range, with: string)
                return updatedText.characters.count <= CharacterLimit
            }
        }
        return true
    }
    
    func handleRegister() {
        view.endEditing(true)
        let loadingView = LoadingView()
        loadingView.showActivityIndicator(viewController: self)
        guard let email = signupView.emailField.text,
            let password = signupView.passwordField.text,
            let username = signupView.usernameField.text,
            let confirmFieldText = self.signupView.confirmEmailField.text else {
                loadingView.hideActivityIndicator(viewController:self)
                print("Form is not valid")
                return
        }
        guard validateEmailInput(email: email, confirm: confirmFieldText) == true else { helpers.setupErrorAlert(viewController: self); return }
        signupLogic(email: email, password: password, username: username, loadingView: loadingView)
    }
    
    func signupLogic(email: String, password: String, username: String, loadingView: LoadingView) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                loadingView.hideActivityIndicator(viewController: self)
                print(error ?? "unable to get specific error")
                return
            }
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let newUser = self.helpers.createUser(uid: uid, username: username, email: email)
            self.setupUser(user: newUser)
            let tabBar = TabBarController()
            self.helpers.loadTabBar(tabBar:tabBar)
        }
    }
    
    func setupUser(user: User) {
        store.firebaseAPI.registerUser(user: user)
        store.currentUserString = FIRAuth.auth()?.currentUser?.uid
        store.firebaseAPI.setupRefs()
        store.currentUser = user
    }
    
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
    
    fileprivate func invalidateStyleFor(field:UITextField) {
        field.layer.borderColor = Constants.Color.mainColor.cgColor
        field.textColor = Constants.Color.mainColor
    }
    
    fileprivate func setAnimationStyleFor(field:UITextField) {
        field.layer.borderColor = Constants.Signup.animationColor.cgColor
        field.textColor = Constants.Signup.animationColor
    }
}
