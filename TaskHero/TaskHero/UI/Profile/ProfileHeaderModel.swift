//
//  ProfileHeaderModel.swift
//  TaskHero
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
    
    let store = UserDataStore.sharedInstance
    var emailLabel: String
    var usernameLabel: String
    var profilePicture: String
    var levelLabel: String
    var joinDate: String
    var joinDateIsHidden: Bool
    
    init() {
        if let user = self.store.currentUser {
            emailLabel = user.email
            joinDateIsHidden = true
            usernameLabel = user.username
            levelLabel = "Level: \(user.level)"
            joinDate = "Joined: \(user.joinDate)"
            if let profilePic = user.profilePicture {
                profilePicture = profilePic
            } else {
                profilePicture = "Void"
            }
        } else {
            emailLabel = "Void"
            usernameLabel = "Void"
            profilePicture = "Void"
            joinDateIsHidden = true
            levelLabel = "Level: Void"
            joinDate = "Joined:  Void"
        }
    }
}
