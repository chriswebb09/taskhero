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
    var emailInvalidated = false
    let CharacterLimit = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = UIColor.white
        signupView.layoutSubviews()
        signupView.emailField.delegate = self
        signupView.confirmEmailField.delegate = self
        signupView.usernameField.delegate = self
        signupView.passwordField.delegate = self
        signupView.signupButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.store.fetchValidUsernames()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        if textField == self.signupView.usernameField {
            let currentUserName = self.signupView.usernameField.text! as NSString
            let updatedText = currentUserName.replacingCharacters(in: range, with: string)
            
            return updatedText.characters.count <= CharacterLimit
        }
        return true
    }
    
    func handleRegister() {
        view.endEditing(true)
        let loadingView = LoadingView()
        guard let email = signupView.emailField.text, let password = signupView.passwordField.text, let username = signupView.usernameField.text else {
            loadingView.hideActivityIndicator(viewController:self)
            print("Form is not valid")
            return
        }
        if (validateEmailInput(email:email, confirm:self.signupView.confirmEmailField.text!)) {
            loadingView.showActivityIndicator(viewController: self)
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                if error != nil {
                    loadingView.hideActivityIndicator(viewController: self)
                    print(error ?? "unable to get specific error")
                    return
                }
                guard let uid = user?.uid else {
                    loadingView.hideActivityIndicator(viewController: self)
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
                let usernamesReference = ref.child("Usernames")
                let usernameValues = [newUser.username:newUser.email] as [String : Any] as NSDictionary
                usernamesReference.updateChildValues(usernameValues as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                    if err != nil {
                        loadingView.hideActivityIndicator(viewController: self)
                        print(err ?? "unable to get specific error i")
                        return
                    }
                    print("sucessfully saved username email reference")
                })
                
                let values = ["Username": newUser.username, "Email": newUser.email, "FirstName": newUser.firstName!, "LastName": newUser.lastName!, "ProfilePicture": newUser.profilePicture!, "ExperiencePoints":newUser.experiencePoints, "Level": newUser.level, "JoinDate":newUser.joinDate, "TasksCompleted": 0] as [String : Any] as NSDictionary
                
                usersReference.updateChildValues(values as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                    if err != nil {
                        loadingView.hideActivityIndicator(viewController: self)
                        print(err ?? "unable to get specific error")
                        return
                    }
                    
                    print("Saved user successfully into Firebase db")
                    self.store.currentUserString = FIRAuth.auth()?.currentUser?.uid
                    self.store.currentUser = newUser
                    // self.store.insertUsername()
                    let tabBar = TabBarController()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tabBar
                })
            })
        } else {
            let alertController = UIAlertController(title: "Invalid", message: "Something is wrong here.", preferredStyle: UIAlertControllerStyle.alert)
            //            let DestructiveAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            //                print("Destructive")
            //            }
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            //alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
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
        }
            
        else if textField == signupView.passwordField {
            textField.resignFirstResponder()
        }
        
        
        //        else if textField == signupView.passwordField {
        //            let nextField = (textField === signupView.passwordField) ? signupView.usernameField : signupView.emailField
        //            nextField.becomeFirstResponder()
        //        }
        
        
        return true
    }
    
    
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextField(textField)
        if textField == self.signupView.usernameField {
            
            print(store.validUsernames)
            if store.validUsernames.contains(self.signupView.usernameField.text!) {
                
                self.signupView.usernameField.layer.borderColor = UIColor(red:0.93, green:0.04, blue:0.04, alpha:1.0).cgColor
                self.signupView.usernameField.textColor = UIColor(red:0.93, green:0.04, blue:0.04, alpha:1.0)
                self.signupView.signupButton.isEnabled = false
            } else if !store.validUsernames.contains(self.signupView.usernameField.text!) {
                self.signupView.usernameField.layer.borderColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0).cgColor
                self.signupView.usernameField.textColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
                self.signupView.signupButton.isEnabled = true
            }
        }
        
        if textField == self.signupView.emailField {
            if !(textField.text?.isValidEmail())! {
                self.signupView.emailField.layer.borderColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0).cgColor
                self.signupView.emailField.textColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0)
            }  else if (textField.text?.isValidEmail() )!{
                //self.signupView.emailField.layer.borderColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0).cgColor
                self.signupView.emailField.textColor = UIColor.blue
            }
        }
        if (validateEmailInput(email: self.signupView.emailField.text!, confirm: self.signupView.confirmEmailField.text!)) && (emailInvalidated) {
            self.signupView.emailField.layer.borderColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0).cgColor
            self.signupView.emailField.textColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0)
            self.signupView.confirmEmailField.layer.borderColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0).cgColor
            self.signupView.confirmEmailField.textColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0)
            Constants().delay(0.9) {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.signupView.usernameField.layer.borderColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0).cgColor
                    self.signupView.usernameField.textColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
                    self.signupView.emailField.layer.borderColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0).cgColor
                    self.signupView.emailField.textColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
                    self.signupView.confirmEmailField.layer.borderColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0).cgColor
                    self.signupView.confirmEmailField.textColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
                })
            }
        } else if textField == self.signupView.confirmEmailField {
            if (!validateEmailInput(email: self.signupView.emailField.text!, confirm: self.signupView.confirmEmailField.text!)) {
                self.signupView.emailField.layer.borderColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0).cgColor
                self.signupView.emailField.textColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0)
                self.signupView.confirmEmailField.layer.borderColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0).cgColor
                self.signupView.confirmEmailField.textColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0)
            }
        }
    }
    
    
    
}


extension SignupViewController {
    func validateEmailInput(email:String, confirm:String) -> Bool {
        let emailLower = email.lowercased()
        let confirmLower = confirm.lowercased()
        if (email.isValidEmail()) && (emailLower == confirmLower) {
            return true
        } else {
            emailInvalidated = true
            return false
        }
    }
    
    func checkTextField(_ textField: UITextField) {
        if (textField.text?.characters.count)! > 5 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                textField.layer.borderColor = UIColor.blue.cgColor
            }, completion: nil)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        textField.textColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        //        textField.layer.borderColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
    }
}
