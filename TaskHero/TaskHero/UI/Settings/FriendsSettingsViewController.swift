//
//  FriendSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsViewController: UIViewController {
    
    // MARK: - Deallocation from memory
    
    deinit {
        print("FriendsSettingsView deallocated")
    }
    
    // MARK: Properties
    
    let friendsSettingsView = FriendsSettingsView()
    let alertPop = AlertPopover()
    
    // MARK: ViewController Initialization Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(friendsSettingsView)
        friendsSettingsView.layoutSubviews()
        friendsSettingsView.searchField.delegate = self
        navigationController?.navigationBar.tintColor = UIColor.white
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
        alertPop.popView.isHidden = false
        friendsSettingsView.searchField.resignFirstResponder()
        alertPop.popView.layer.opacity = 0
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = Constants.Settings.dismissedOpacity
        alertPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1) {
            self.alertPop.popView.layer.opacity = 1
            self.alertPop.containerView.layer.opacity = 0.1
        }
        alertPop.alertPopView.resultLabel.text = "No results found. Please try again later."
        alertPop.alertPopView.doneButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        alertPop.alertPopView.cancelButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
    }
    
    // Hides popover UI - prioritised to main thread when user hits dismiss button
    
    func dismissButton() {
        self.alertPop.popView.isHidden = true
        self.alertPop.containerView.isHidden = true
        self.alertPop.hidePopView(viewController: self)
        UINavigationController().popViewController(animated: false)
        
    }
    
    func hide() {
        self.alertPop.popView.isHidden = true
        self.alertPop.containerView.isHidden = true
        self.alertPop.hidePopView(viewController: self)
    }
}
