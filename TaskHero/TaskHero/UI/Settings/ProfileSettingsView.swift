//
//  ProfileSettings.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class ProfileSettingsView: UIView {
    
    // MARK: - UIElements
    
    let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.textColor = UIColor.black
        profileLabel.text = "User Settings"
        profileLabel.font = Constants.Font.fontLarge
        profileLabel.textAlignment = .center
        profileLabel.layer.masksToBounds = true
        return profileLabel
    }()
}

extension ProfileSettingsView {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    // MARK: - Configure
    
    fileprivate func setupConstraints() {
        addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Settings.friendsHeaderLabelHeight).isActive = true
        profileLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Profile.heightMultiplier).isActive = true // 0.5
        profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Profile.labelTopOffset).isActive = true
    }
    
}
