//
//  User.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit 

class User: NSObject {
    var uid: String
    var email: String
    var password: String
    var firstName: String?
    let lastName: String?
    var profilePicture: UIImage?
    var tasks: [Task]?
    
    
    init(uid: String, email: String, password: String, firstName: String?, lastName: String?, profilePicture: UIImage?, tasks: [Task]?) {
        self.uid = uid
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.tasks = tasks
        super.init()
    }
    
    override convenience init() {
        self.init(uid:"", email:"", password: "", firstName: nil, lastName:nil, profilePicture: nil, tasks:nil)
    }
    
    
}
