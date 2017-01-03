//
//  FriendSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsViewController: UIViewController, UITextFieldDelegate {
    
    let friendsSettingsView = FriendsSettingsView()
    let alertPop = AlertPopover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(friendsSettingsView)
        friendsSettingsView.layoutSubviews()
        friendsSettingsView.searchField.delegate = self
        navigationController?.navigationBar.tintColor = UIColor.white
        friendsSettingsView.searchButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
