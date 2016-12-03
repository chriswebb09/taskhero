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
        view.addSubview(friendsSettingsView)
        friendsSettingsView.layoutSubviews()
        navigationController?.navigationBar.tintColor = UIColor.white
        friendsSettingsView.addTaskButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FriendsSettingsViewController {
    
    func popup() {
        alertPop.popView.isHidden = false
        alertPop.popView.layer.opacity = 0
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = 0
        alertPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1, animations: {
            self.alertPop.popView.layer.opacity = 1
            self.alertPop.containerView.layer.opacity = 0.1
        })
        alertPop.popView.resultLabel.text = "No results found. Please try again later."
        alertPop.popView.cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        alertPop.popView.doneButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        
    }
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
        navigationController?.popViewController(animated: false)
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
}
