//
//  SignupViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    let store = DataStore.sharedInstance
    
    let signupView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.confirmEmailField.delegate = self
        signupView.usernameField.delegate = self
        signupView.passwordField.delegate = self
        signupView.signupButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleRegister() {
        guard let email = signupView.emailField.text, let password = signupView.passwordField.text, let username = signupView.usernameField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error ?? "unable to get specific error")
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            
            let ref = FIRDatabase.database().reference()
            let newUser = User()
            newUser.username = username
            newUser.email = email
            newUser.profilePicture = "None"
            newUser.firstName = "N/A"
            newUser.lastName = "N/A"
            newUser.experiencePoints = 0
            newUser.tasks = [Task]()
            let usersReference = ref.child("Users").child(uid)
            let values = ["Username": newUser.username, "Email": newUser.email, "FirstName": newUser.firstName, "LastName": newUser.lastName, "ProfilePicture": newUser.profilePicture, "ExperiencePoints":newUser.experiencePoints, "Level": newUser.level, "JoinDate":newUser.joinDate] as [String : Any]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err ?? "unable to get specific error")
                    return
                }
                
                print("Saved user successfully into Firebase db")
                self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
                
                self.store.currentUser = newUser
                
                let tabBar = TabBarController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBar
                
            })
            
        })
    }
    
    
}
