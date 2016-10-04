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
    
    var databaseRef: FIRDatabaseReference!
    
    var signedIn = false
    var displayName: String?
    
    let signupView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.databaseRef = FIRDatabase.database().reference(withPath:"users")
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
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let uid = user?.uid else { return }
                print("User signed in!")
                self.databaseRef?.child("\(uid)/email").setValue(FIRAuth.auth()!.currentUser!.email)
                let tabBar = TabBarController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBar
            }
        }
    }
    
}
