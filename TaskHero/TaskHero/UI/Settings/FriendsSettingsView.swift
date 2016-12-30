//
//  FriendSettingsView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class FriendsSettingsView: UIView {
    
    // MARK: - UI Elements
    // =========================================================================
    
    let friendsHeaderLabel: UILabel = {
        let friendsHeaderLabel = UILabel()
        friendsHeaderLabel.textColor = UIColor.black
        friendsHeaderLabel.text = "Add Friends"
        friendsHeaderLabel.font = Constants.Font.fontLarge
        friendsHeaderLabel.textAlignment = .center
        friendsHeaderLabel.layer.masksToBounds = true
        return friendsHeaderLabel
    }()
    
    var searchField: TextFieldExtension = {
        let searchField = TextFieldExtension()
        searchField.placeholder = "Search by email"
        searchField.font = Constants.signupFieldFont
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchField.layer.borderWidth = Constants.Settings.searchFieldBorderWidth
        return searchField
    }()
    
    var searchButton: UIButton = {
        var searchButton = UIButton()
        searchButton.layer.borderWidth = Constants.Settings.searchFieldBorderWidth
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = Constants.Settings.searchButtonColor
        searchButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor.white, for: .normal)
        return searchButton
    }()
    
}

extension FriendsSettingsView {
    
    // MARK: - Initialization
    // =========================================================================
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    // MARK: - Configure
    // =========================================================================
    
    func configureView(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.Settings.friendsHeaderLabelHeight).isActive = true
        view.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConstraints() {
        configureView(view: friendsHeaderLabel)
        friendsHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.Settings.friendsHeaderLabelTopOffset).isActive = true
        configureView(view: searchField)
        searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Settings.searchFieldLeadOffset).isActive = true
        searchField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -bounds.height * Constants.Settings.friendSettingCenterYOffset).isActive = true
        configureView(view: searchButton)
        searchButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height * Constants.Settings.searchButtonCenterYOffset).isActive = true
    }
}
