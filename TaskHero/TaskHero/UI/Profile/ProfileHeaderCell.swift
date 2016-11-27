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
    
    let joinDateLabel: UILabel = {
        let joinDateLabel = UILabel()
        joinDateLabel.textColor = UIColor.black
        joinDateLabel.font = Constants.Font.profileFontMed
        joinDateLabel.textAlignment = .right
        joinDateLabel.layer.masksToBounds = true
        return joinDateLabel
    }()
    
    lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = Constants.Font.taskNameFont
        usernameLabel.textAlignment = .right
        usernameLabel.sizeToFit()
        usernameLabel.layer.masksToBounds = true
        return usernameLabel
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.textColor = UIColor.black
        emailLabel.font = Constants.Font.profileFontMed
        emailLabel.textAlignment = .right
        emailLabel.layer.masksToBounds = true
        return emailLabel
    }()
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.textColor = UIColor.black
        levelLabel.font = Constants.Font.profileFontMed
        levelLabel.textAlignment = .right
        levelLabel.sizeToFit()
        levelLabel.layer.masksToBounds = true
        return levelLabel
    }()
    
    lazy var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    fileprivate func setupConstraints() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        
        contentView.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(joinDateLabel)
        joinDateLabel.translatesAutoresizingMaskIntoConstraints = false
        joinDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.profileHeaderLabelHeight).isActive = true
        joinDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        joinDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        joinDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        contentView.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.heightAnchor.constraint(equalToConstant: 75).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 75).isActive = true
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        contentView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        levelLabel.bottomAnchor.constraint(equalTo: profilePicture.bottomAnchor).isActive = true
    }
    
    func configureCell(user: User) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped))
        usernameLabel.text = user.username
        emailLabel.text = user.email
        joinDateLabel.text = "Joined: \(user.joinDate)"
        joinDateLabel.isHidden = true
        levelLabel.text = "Level: \(user.level)"
        profilePicture.isUserInteractionEnabled = true
        profilePicture.image = UIImage(named: "defaultUserImage")
        profilePicture.addGestureRecognizer(tap)
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
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
