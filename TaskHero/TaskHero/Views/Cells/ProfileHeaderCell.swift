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

class ProfileHeaderCell: UITableViewCell {
    
    static let cellIdentifier = "ProfileHeaderCell"
    
    let joinDateLabel: UITextView = {
        let joinDateLabel = UITextView()
        joinDateLabel.textColor = UIColor.black
        joinDateLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        joinDateLabel.textAlignment = .right
        joinDateLabel.layer.masksToBounds = true
        joinDateLabel.isScrollEnabled = false
        return joinDateLabel
    }()
    
    lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        usernameLabel.textAlignment = .right
        usernameLabel.sizeToFit()
        usernameLabel.layer.masksToBounds = true
        return usernameLabel
    }()
    
    let emailLabel: UITextView = {
        let emailLabel = UITextView()
        emailLabel.textColor = UIColor.black
        emailLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        emailLabel.textAlignment = .right
        emailLabel.layer.masksToBounds = true
        emailLabel.isScrollEnabled = false
        return emailLabel
    }()
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.textColor = UIColor.black
        levelLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        levelLabel.textAlignment = .right
        levelLabel.sizeToFit()
        levelLabel.layer.masksToBounds = true
        return levelLabel
    }()
    
    lazy var profilePicture: UIImageView = {
        let imageView = UIImageView()
        //imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    
    func setupConstraints() {
        
        contentView.addSubview(usernameLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.addSubview(emailLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        
        
        contentView.addSubview(joinDateLabel)
        
        joinDateLabel.translatesAutoresizingMaskIntoConstraints = false
        joinDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        joinDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        joinDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        joinDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        
        contentView.addSubview(profilePicture)
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.heightAnchor.constraint(equalToConstant: 130).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 130).isActive = true
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        contentView.addSubview(levelLabel)
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        levelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        usernameLabel.text = ""
        profilePicture.image = nil
    }
}
