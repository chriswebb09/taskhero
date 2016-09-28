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
    
    static let sharedInstance = DataStore()
    
    var database : FIRDatabase?
    var ref : FIRDatabaseReference?
    
    var signedIn = false
    var displayName: String?
    
    func data() {
        self.database = FIRDatabase.database()
        self.ref = self.database?.reference()
    }
}
