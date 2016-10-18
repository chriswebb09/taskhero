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
    
    let CharacterLimit = 11
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(signupView)
        navigationController?.navigationBar.tintColor = UIColor.white
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        if textField == self.signupView.usernameField {
            let currentUserName = self.signupView.usernameField.text! as NSString
            let updatedText = currentUserName.replacingCharacters(in: range, with: string)
            
            return updatedText.characters.count <= CharacterLimit
        }
        return true
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
        
        
        validateEmailInput(email:email, confirm:self.signupView.confirmEmailField.text!)
        
        
        
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
            
            let values = ["Username": newUser.username, "Email": newUser.email, "FirstName": newUser.firstName!, "LastName": newUser.lastName!, "ProfilePicture": newUser.profilePicture!, "ExperiencePoints":newUser.experiencePoints, "Level": newUser.level, "JoinDate":newUser.joinDate, "TasksCompleted": 0] as [String : Any] as NSDictionary
            
            print(values)
            print(values as NSDictionary)
            
            usersReference.updateChildValues(values as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.textColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
//        textField.layer.borderColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.characters.count)! > 5 {
             UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                textField.layer.borderColor = UIColor.blue.cgColor
            }, completion: nil)
        }
//        textField.textColor = UIColor.lightGray
//        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func validateEmailInput(email:String, confirm:String) -> Bool {
        if (email.isValidEmail()) && (confirm.lowercased() == email.lowercased()){
            print("valid email")
            return true
        } else {
            print("invalid email")
            return false
        }
    }
    


    
}
