//
//  DataStore.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class DataStore {
    
    var currentUser: User!
    var currentUserString: String!
    var tasks = [Task]()
    
    static let sharedInstance = DataStore()
    
}
