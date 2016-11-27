//
//  ProfileSettingsCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileSettingsCellDelegate: class {
    func editButtonTapped()
}

class ProfileSettingsCell: UITableViewCell, ProfileSettingsCellDelegate {
    
    static let cellIdentifier = "ProfileSettingsCell"
    
    var delegate: ProfileSettingsCellDelegate?
    
    let profileSettingLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.textColor = UIColor.settingsBackground()
        profileLabel.font = Constants.Font.fontNormal
        profileLabel.textAlignment = .left
        profileLabel.layer.masksToBounds = true
        return profileLabel
    }()
    
    let button: TagButton = {
        
        //let button = ButtonType.system(title: "Edit", color: UIColor.blue)
        let button = ButtonType.tag(title: "Edit", color: UIColor.blue, tag: 20, index: IndexPath())
        let uiElement = button.tagButton
        //uiElement.accessibilityLabel
        uiElement.layer.borderWidth = 0
        return uiElement
    }()
    
    lazy var profileSettingField: TextFieldExtension = {
        let taskNameField = TextFieldExtension()
       //taskNameField.placeholder = "Task name"
        taskNameField.font = Constants.signupFieldFont
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = 2
        taskNameField.layer.borderWidth = 1
        taskNameField.isHidden = true
        return taskNameField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        selectionStyle = UITableViewCellSelectionStyle.none
        contentView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        //contentView.backgroundColor = UIColor.settingsBackground()
        contentView.addSubview(profileSettingLabel)
        profileSettingLabel.translatesAutoresizingMaskIntoConstraints = false
        profileSettingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:0.5).isActive = true
        profileSettingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        profileSettingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width * 0.05).isActive = true
        //profileSettingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileSettingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:0.5).isActive = true
        button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        //button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(profileSettingField)
        profileSettingField.translatesAutoresizingMaskIntoConstraints = false
        profileSettingField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:0.5).isActive = true
        profileSettingField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        profileSettingField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width * 0.05).isActive = true
        //profileSettingField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileSettingField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configureCell(setting:String) {
        layoutSubviews()
        profileSettingField.isHidden = true
        profileSettingLabel.text = setting
        //button.accessibilityLabel = setting
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileSettingLabel.text = ""
    }
    
    func editButtonTapped() {
        delegate?.editButtonTapped()
        profileSettingLabel.isHidden = true
        profileSettingField.isHidden = false 
        print("profile pic tapped\n\n\n\n\n\n")
    }
}


