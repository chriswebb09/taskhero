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
    
    let store = DataStore.sharedInstance
    
    let signupView = SignupView()
    var emailInvalidated = false
    let CharacterLimit = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        setupDelegate()
        signupView.signupButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.store.firebaseAPI.fetchValidUsernames()
    }
    
    private func setupDelegate() {
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.confirmEmailField.delegate = self
        signupView.usernameField.delegate = self
        signupView.passwordField.delegate = self
    }
}

extension SignupViewController {
    
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
        guard let email = signupView.emailField.text, let password = signupView.passwordField.text, let username = signupView.usernameField.text else {
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
                guard let uid = user?.uid else {
                    loadingView.hideActivityIndicator(viewController: self)
                    return
                }
                self.store.firebaseAPI.setupRefs()
                var newUser = self.createUser(uid: uid, username: username, email: email)
                self.store.currentUser = newUser
                self.store.currentUserString = uid
                self.insertUser(uid: uid, user: newUser)
                self.setupTabBar()
            }
        }
        
        
    }
    
    func insertUser(uid: String, user:User) {
        let userData: NSDictionary = ["Email": user.email,
                                      "FirstName": user.firstName ?? " ",
                                      "LastName": user.lastName ?? " ",
                                      "ProfilePicture": user.profilePicture ?? " ",
                                      "ExperiencePoints": user.experiencePoints,
                                      "Level": user.level,
                                      "JoinDate": user.joinDate,
                                      "Username": user.username,
                                      "TasksCompleted": user.numberOfTasksCompleted]
        //elf.store.firebaseAPI.usernameRef
        self.store.firebaseAPI.usersRef.updateChildValues(["/\(self.store.currentUserString!)": userData])
    }
    
    fileprivate func setupTabBar() {
        let tabBar = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
    
    private func createUser(uid: String, username:String, email:String) -> User {
        let newUser = User()
        
        newUser.uid = uid
        newUser.username = username
        newUser.email = email
        newUser.profilePicture = "None"
        newUser.firstName = "N/A"
        newUser.lastName = "N/A"
        newUser.experiencePoints = 0
        newUser.tasks = [Task]()
        
        return newUser
    }
    
}
