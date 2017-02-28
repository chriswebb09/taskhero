//
//  ProfileSettingsCell.swift
//  TaskHero
//

import UIKit
import SnapKit

protocol ProfileSettingsCellDelegate: class {
    func editButtonTapped()
}

final class ProfileSettingsCell: UITableViewCell, ProfileSettingsCellDelegate {
    
    static let cellIdentifier = "ProfileSettingsCell"
    var delegate: ProfileSettingsCellDelegate?
    
    // MARK: - UIElements
    
    var profileSettingLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.textAlignment = .left
        profileLabel.layer.masksToBounds = true
        profileLabel.textColor = .settingsBackground
        profileLabel.font = Constants.Font.fontNormal
        return profileLabel
    }()
    
    var button: TagButton = {
        let button = ButtonType.tag(title: "Edit", color: UIColor.blue, tag: 20, index: IndexPath()).tagButton
        button.layer.borderWidth = 0
        return button
    }()
    
    var profileSettingField: TextFieldExtension = {
        let taskNameField = TextFieldExtension()
        taskNameField.font = Constants.signupFieldFont
        taskNameField.layer.borderColor = UIColor.lightGray.cgColor
        taskNameField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        taskNameField.layer.borderWidth = Constants.Border.borderWidth
        taskNameField.isHidden = true
        return taskNameField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        layoutSetup()
    }
    
    func layoutSetup() {
        selectionStyle = .none
        contentView.layer.masksToBounds = true
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
    }
    
    func configureCell(setting:String, controller: ProfileSettingsViewController) {
        delegate = controller
        layoutSubviews()
        profileSettingLabel.text = setting
        if setting.contains("N/A") {
            profileSettingLabel.text = "FirstName LastName"
        }
        profileSettingField.isHidden = true
    }
    
    private func configureView(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.Settings.Profile.profileSettingsLabelWidth)
        }
    }
    
    private func addProfileSetttingLabel() {
        configureView(view: profileSettingLabel)
        
        profileSettingLabel.snp.makeConstraints { make in
            make.height.equalTo(self)
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(contentView.bounds.width * Constants.Dimension.settingsOffset)
        }
    }
    
    private func addButton() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(contentView.snp.height)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.Settings.Profile.profileViewHeightAnchor)
        }
    }
    
    private func addProfileSettingsField() {
        configureView(view: profileSettingField)
        
        profileSettingField.snp.makeConstraints { make in
            make.height.equalTo(self)
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(contentView.bounds.width * Constants.Dimension.settingsOffset)
        }
    }
    
    fileprivate func setupConstraints() {
        addProfileSetttingLabel()
        addButton()
        addProfileSettingsField()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileSettingLabel.text = ""
    }
    
    // MARK: - Cell Delegate Method
    
    func editButtonTapped() {
        delegate?.editButtonTapped()
        
        profileSettingLabel.isHidden = true
        profileSettingField.isHidden = false
        print("profile pic tapped\n\n\n\n\n\n")
    }
}
