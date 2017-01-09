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
    
    // ====================
    // MARK: - Properties
    // ====================
    
    let store = DataStore.sharedInstance
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
        self.store.firebaseAPI.fetchValidUsernames()
    }
    
    private func setupSignupView() {
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.confirmEmailField.delegate = self
        signupView.usernameField.delegate = self
        signupView.passwordField.delegate = self
    }
}

extension SignupViewController {
    
    // =======================================
    // MARK: - UITextfield Delegate Methods
    // =======================================
    
    // Checks for character length (implemented for username length) if characters exceed allowed range, text field will no longer except new characters
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        if textField == self.signupView.usernameField {
            let currentUserName = self.signupView.usernameField.text! as NSString
            let updatedText = currentUserName.replacingCharacters(in: range, with: string)
            return updatedText.characters.count <= CharacterLimit
        }
        return true
    }
}

extension SignupViewController {
    
    func handleRegister() {
        view.endEditing(true)
        let loadingView = LoadingView()
        guard let email = signupView.emailField.text,
            let password = signupView.passwordField.text,
            let username = signupView.usernameField.text else {
                loadingView.hideActivityIndicator(viewController:self)
                print("Form is not valid")
                return
        }
        if validateEmailInput(email:email, confirm:self.signupView.confirmEmailField.text!) {
            loadingView.showActivityIndicator(viewController: self)
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
                if error != nil {
                    loadingView.hideActivityIndicator(viewController: self)
                    print(error ?? "unable to get specific error")
                    return
                }
                if let uid = FIRAuth.auth()?.currentUser?.uid {
                    self.setupUser(uid: uid, username: username, email: email)
                }
                self.helpers.loadTabBar()
            }
        } else {
            let alertController = UIAlertController(title: "Invalid", message: "Something is wrong here.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { result in print("Okay") }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    func setupUser(uid: String, username:String, email:String) {
        let newUser = self.helpers.createUser(uid:uid, username: username, email: email)
        self.store.firebaseAPI.registerUser(user: newUser)
        self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
        self.store.firebaseAPI.setupRefs()
        self.store.currentUser = newUser
    }
}
