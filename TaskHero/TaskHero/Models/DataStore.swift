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
    var dataSnapshot = [FIRDataSnapshot]()
    var database : FIRDatabase?
    var ref : FIRDatabaseReference?
    var refHandle: FIRDatabaseHandle!
    var signedIn = false
    var displayName: String?
    
    func data() {
        self.database = FIRDatabase.database()
        //self.ref = self.database?.reference()
        self.ref = self.database?.reference(withPath: "users")
    }
    
    func loadDatabase(){
        let uid = FIRAuth.auth()?.currentUser?.uid
        self.ref = FIRDatabase.database().reference()
        refHandle = self.ref?.child(uid!).observe(.childAdded, with: { snapshot in
            self.refHandle = self.ref?.child(uid!).observe(.childAdded, with: { snapshot in
                self.dataSnapshot.append(snapshot)
                let snapshotValue = snapshot.value as? NSDictionary
                guard (snapshotValue?["user"] as? [String: String]) != nil
                    else {
                        print("error getting snapshot")
                        return
                }
            })
        })
    }
    
}
