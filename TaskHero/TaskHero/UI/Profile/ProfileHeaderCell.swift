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

class ProfileHeaderCell: UITableViewCell, ProfileHeaderCellDelegate {
    
    static let cellIdentifier = "ProfileHeaderCell"
    
    var delegate: ProfileHeaderCellDelegate?
    
    dynamic let joinDateLabel: UILabel = {
        let joinDateLabel = UILabel()
        joinDateLabel.font = Constants.Font.profileFontMed
        return joinDateLabel
    }()
    
    lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = Constants.Font.taskNameFont
        return usernameLabel
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = Constants.Font.profileFontMed
        return emailLabel
    }()
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = Constants.Font.profileFontMed
        return levelLabel
    }()
    
    lazy var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func configureLabel(label:UILabel) {
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.layer.masksToBounds = true
        label.sizeToFit()
    }
    
    func configureConstraints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    fileprivate func setupConstraints() {
        contentView.addSubview(levelLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(joinDateLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profilePicture)
        
        configureLabel(label: emailLabel)
        configureLabel(label: levelLabel)
        configureLabel(label: usernameLabel)
        configureLabel(label: joinDateLabel)
        
        configureConstraints(label: levelLabel)
        configureConstraints(label: usernameLabel)
        configureConstraints(label: usernameLabel)
        configureConstraints(label: usernameLabel)
        
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        joinDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        joinDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        joinDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.heightAnchor.constraint(equalToConstant: 75).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 75).isActive = true
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        levelLabel.bottomAnchor.constraint(equalTo: profilePicture.bottomAnchor).isActive = true
    }
    
    func configureCell(user: User) {
       layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        emailLabel.text = user.email
        joinDateLabel.isHidden = true
        usernameLabel.text = user.username
        levelLabel.text = "Level: \(user.level)"
        joinDateLabel.text = "Joined: \(user.joinDate)"
        profilePicture.isUserInteractionEnabled = true
        profilePicture.image = UIImage(named: "defaultUserImage")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped))
        profilePicture.addGestureRecognizer(tap)
        layoutSubviews()
        layoutIfNeeded()
    }
    
    func profilePictureTapped() {
        print("profile pic tapped\n\n\n\n\n\n")
        delegate?.profilePictureTapped()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = ""
        profilePicture.image = nil
    }
}
