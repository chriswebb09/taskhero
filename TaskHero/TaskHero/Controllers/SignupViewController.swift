//
//  SignupViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    let signupView = SignupView()
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signupView)
        signupView.layoutSubviews()
        signupView.signUpButton.addTarget(self, action: #selector(createUserButtonTapped), for: .touchUpInside)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createUserButtonTapped() {
        
        guard let email = signupView.emailAddressTextField.text, let password = signupView.passwordTextField.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            let uid = NSUUID().uuidString
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User signed in!")
                self.store.ref?.child("data/users").updateChildValues(["\(FIRAuth.auth()!.currentUser!.uid)":["userID":uid]])
                
                let tabBar = TabBarController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBar
            }
        }
    }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
