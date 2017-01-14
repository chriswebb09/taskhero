
//
//  ProfileHeaderCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit

protocol ProfileHeaderCellDelegate: class {
    func profilePictureTapped()
}

final class ProfileHeaderCell: UITableViewCell {
    
    // MARK: - ProfileHeaderCell deallocated from memory
    
    deinit {
        print("ProfileHeaderCell deallocated")
    }
    
    // MARK: - Internal Variables
    
    static let cellIdentifier = "ProfileHeaderCell"
    weak var delegate: ProfileHeaderCellDelegate?
    var profileHeaderCellModel = ProfileHeaderCellModel()
    
    
    lazy var joinDateLabel: UILabel = {
        let joinDateLabel = UILabel()
        joinDateLabel.font = Constants.Font.fontLarge
        return joinDateLabel
    }()
    
    lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = Constants.Font.bolderFontLarge
        return usernameLabel
    }()
    
    lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = Constants.Font.fontLarge
        return emailLabel
    }()
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = Constants.Font.fontMedium
        levelLabel.textAlignment = .right
        return levelLabel
    }()
    
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = Constants.Dimension.mainWidth
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
}


extension ProfileHeaderCell {
    
    fileprivate func configureLargeLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.Font.fontLarge
        return label
    }
}

extension ProfileHeaderCell {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        contentView.layoutIfNeeded()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
}

extension ProfileHeaderCell {
    
    // MARK: - Configuring Cell
    
    fileprivate func configureLabel(label:UILabel) {
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.sizeToFit()
    }
    
    fileprivate func configureConstraints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:Constants.Dimension.bottomOffset).isActive = true
    }
    
    /* adds levelLabel, emailLabel, joinDateLabel, usernameLabel, profilePicture to subview */
    /* calls configureLabel on levelLabel, emailLabel, joinDateLabel, usernameLabel */
    /* calls configureConstraints on levelLabel, emailLabel, usernameLabel */
    
    fileprivate func addConfigures() {
        contentView.addSubview(levelLabel)
        configureLabel(label: levelLabel)
        configureConstraints(label: levelLabel)
        contentView.addSubview(emailLabel)
        configureLabel(label: emailLabel)
        configureConstraints(label: emailLabel)
        contentView.addSubview(joinDateLabel)
        configureLabel(label: joinDateLabel)
        configureConstraints(label: joinDateLabel)
        contentView.addSubview(usernameLabel)
        configureLabel(label: usernameLabel)
        configureConstraints(label: usernameLabel)
        contentView.addSubview(profilePicture)
    }
    
    fileprivate func setupConstraints() {
        addConfigures()
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Dimension.mainWidth).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: profilePicture.topAnchor).isActive  = true
        
        levelLabel.bottomAnchor.constraint(equalTo: profilePicture.bottomAnchor).isActive = true
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Dimension.mainWidth).isActive = true
        joinDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        
        joinDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Dimension.mainWidth).isActive = true
        joinDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Dimension.mainOffset).isActive = true
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * Constants.Profile.ProfilePicture.profilePictureHeight).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * Constants.Profile.ProfilePicture.profilePictureWidth).isActive = true
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Profile.Offset.topOffset).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.Dimension.topOffset).isActive = true
    }
}

extension ProfileHeaderCell {
    
    /*
     - Public configureCell method - taskes autoHeight parameter of type UIViewAutoresizing
     - called in ParentViewController - in this case that is either ProfileViewController or HomeViewController
     */
    
    func configureCell(autoHeight: UIViewAutoresizing, gesture:UIGestureRecognizer) {
        contentView.autoresizingMask = autoHeight
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped))
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        emailLabel.text = profileHeaderCellModel.emailLabel
        joinDateLabel.isHidden = profileHeaderCellModel.joinDateIsHidden
        usernameLabel.text = profileHeaderCellModel.usernameLabel
        levelLabel.text = profileHeaderCellModel.levelLabel
        joinDateLabel.text = profileHeaderCellModel.joinDate
        profilePicture.isUserInteractionEnabled = true
        profilePicture.image = UIImage(named: "defaultUserImage")
        profilePicture.addGestureRecognizer(gesture)
        layoutSubviews()
        layoutIfNeeded()
    }
}

extension ProfileHeaderCell: ProfileHeaderCellDelegate {
    
    // MARK: - Delegate Methods
    
    // Implementation of delegate method - May be deleted either in HomeViewController or ProfileViewController because functionality is redundant
    
   public func profilePictureTapped() {
        print("profile pic tapped\n\n\n\n\n\n")
        delegate?.profilePictureTapped()
    }
}

extension ProfileHeaderCell {
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = ""
        profilePicture.image = nil
    }
}
