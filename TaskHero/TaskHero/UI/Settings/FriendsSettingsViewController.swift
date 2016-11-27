//
//  FriendSettingsViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class FriendsSettingsViewController: UIViewController {
    
    let friendsSettingsView = FriendsSettingsView()
    let alertPop = AlertPopover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(friendsSettingsView)
        friendsSettingsView.layoutSubviews()
        friendsSettingsView.addTaskButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popup() {
        alertPop.popView.isHidden = false
        alertPop.showPopView(viewController: self)
        alertPop.popView.resultLabel.text = friendsSettingsView.taskNameField.text!
        alertPop.popView.doneButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        alertPop.popView.cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.hidePopView(viewController: self)
        navigationController?.popViewController(animated: false)
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.hidePopView(viewController: self)
        //navigationController?.popViewController(animated: false)
    }
    
}
