//
//  FriendSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsViewController: UIViewController {
    
    // MARK: Properties
    
    let friendsSettingsView = FriendsSettingsView()
    let alertPop = AlertPopover()
    
    // MARK: ViewController Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(friendsSettingsView)
        friendsSettingsView.layoutSubviews()
        friendsSettingsView.searchField.delegate = self
        friendsSettingsView.searchButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
    }
}

extension FriendsSettingsViewController: UITextFieldDelegate {
    
    // MARK: - Textfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // MARK: - Delegate methods
    
    func popup() {
        alertPop.showPopView(viewController: self)
        friendsSettingsView.searchField.resignFirstResponder()
        alertPop.alertPopView.resultLabel.text = "No results found."
        alertPop.alertPopView.doneButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        alertPop.alertPopView.cancelButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
    }
    
    // Hides popover UI - prioritised to main thread when user hits dismiss button
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
        UINavigationController().popViewController(animated: false)
        
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
}
