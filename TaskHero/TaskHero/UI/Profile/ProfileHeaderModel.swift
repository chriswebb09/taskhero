//
//  ProfileHeaderModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileHeaderModel {
    var joinDate: String { get }
    var levelLabel: String { get }
    var profilePicture: String { get }
    var usernameLabel: String { get }
    var emailLabel: String { get }
}

struct ProfileHeaderCellModel {
    
    // MARK: - Internal Variables
    
    let store = UserDataStore.sharedInstance

    internal var emailLabel: String
    internal var usernameLabel: String
    internal var profilePicture: String
    internal var levelLabel: String
    internal var joinDate: String
    internal var joinDateIsHidden: Bool

    
    // MARK: - Initialization
    
    init() {
        self.emailLabel = (self.store.currentUser?.email)!
        self.usernameLabel = (self.store.currentUser?.username)!
        self.profilePicture = (self.store.currentUser?.profilePicture!)!
        self.levelLabel = "Level: \((self.store.currentUser?.level)!)"
        self.joinDate = "Joined: \((self.store.currentUser?.joinDate)!)"
        self.joinDateIsHidden = true
    }
}
