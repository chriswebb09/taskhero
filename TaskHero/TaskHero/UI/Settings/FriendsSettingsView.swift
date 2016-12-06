//
//  FriendSettingsView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsView: UIView {
    
    dynamic let friendsHeaderLabel: UILabel = {
        let friendsHeaderLabel = UILabel()
        friendsHeaderLabel.textColor = UIColor.black
        friendsHeaderLabel.text = "Add Friends"
        friendsHeaderLabel.font = Constants.Font.fontLarge
        friendsHeaderLabel.textAlignment = .center
        friendsHeaderLabel.layer.masksToBounds = true
        return friendsHeaderLabel
    }()
    
    lazy var searchField: TextFieldExtension = {
        let searchField = TextFieldExtension()
        searchField.placeholder = "Search by email"
        searchField.font = Constants.signupFieldFont
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchField.layer.borderWidth = Constants.Settings.searchFieldBorderWidth
        return searchField
    }()
    
    lazy var searchButton: UIButton = {
        var searchButton = UIButton()
        searchButton.layer.borderWidth = Constants.Settings.searchFieldBorderWidth
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = Constants.Settings.searchButtonColor
        searchButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor.white, for: .normal)
        return searchButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        addSubview(friendsHeaderLabel)
        friendsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        friendsHeaderLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Settings.friendsHeaderLabelHeight).isActive = true
        friendsHeaderLabel.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        friendsHeaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        friendsHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Settings.friendsHeaderLabelTopOffset).isActive = true
        
        addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        searchField.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Settings.searchFieldLeadOffset).isActive = true
        searchField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -bounds.height * Constants.Settings.friendSettingCenterYOffset).isActive = true
        
        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Settings.searchButtonWidth).isActive = true
        searchButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Settings.searchButtonHeight).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height * Constants.Settings.searchButtonCenterYOffset).isActive = true
    }
    
}
