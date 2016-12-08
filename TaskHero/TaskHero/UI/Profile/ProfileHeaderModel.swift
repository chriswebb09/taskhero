//
//  ProfileHeaderModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol ProfileHeaderVM {
    
    var user: User? { get set }
    var joinDate: String { get }
    var levelLabel: String { get }
    var profilePicture: String { get }
    var usernameLabel: String { get }
    var emailLabel: String { get }
    
}


class ProfileHeaderCellViewModel: ProfileHeaderVM {
    
    let store = DataStore.sharedInstance
    
    internal var user: User?
    internal var emailLabel: String
    internal var usernameLabel: String
    internal var profilePicture: String
    internal var levelLabel: String
    internal var joinDate: String
    
    init() {
        self.user = self.store.currentUser
        self.emailLabel = (self.user?.email)!
        self.usernameLabel = (self.user?.username)!
        self.profilePicture = (self.user?.profilePicture!)!
        self.levelLabel = (self.user?.level)!
        self.joinDate = (self.user?.joinDate)!
    }
    
}
