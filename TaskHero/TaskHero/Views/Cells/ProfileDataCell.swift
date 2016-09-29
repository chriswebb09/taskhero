//
//  ProfileDataCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileDataCellDelegate: class {
    func logoutButtonPressed()
    func profilePictureTapped()
}

class ProfileDataCell: UITableViewCell {
    
    weak var delegate: ProfileHeaderCellDelegate?
    
    static let cellIdentifier = "dataCell"
    
    let profilePicture = UIImageView()
    var fullNameLabel = UILabel()
    var teamsLabel = UILabel()
    var joinDateLabel = UILabel()
    var experiencePointsLabel = UILabel()
    var levelLabel = UILabel()
    var publicTasks = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        contentView.addSubview(profilePicture)
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        profilePicture.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        
        //profilePicture.frame.size = CGSize(width: 50, height: 50)
        //profilePicture.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        //profilePicture.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        
        contentView.addSubview(fullNameLabel)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        fullNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-10).isActive = true
        fullNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
        
        contentView.addSubview(teamsLabel)
        teamsLabel.translatesAutoresizingMaskIntoConstraints = false
        teamsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        teamsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-10).isActive = true
        teamsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
        
        contentView.addSubview(joinDateLabel)
        joinDateLabel.translatesAutoresizingMaskIntoConstraints = false
        joinDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160).isActive = true
        joinDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        contentView.addSubview(experiencePointsLabel)
        experiencePointsLabel.translatesAutoresizingMaskIntoConstraints = false
        experiencePointsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:200).isActive = true
        experiencePointsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        contentView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:240).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:20).isActive = true
        
        contentView.addSubview(publicTasks)
        publicTasks.translatesAutoresizingMaskIntoConstraints = false
        publicTasks.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupView() {
        fullNameLabel.sizeToFit()
        fullNameLabel.textColor = UIColor.black
        
        teamsLabel.sizeToFit()
        teamsLabel.textColor = UIColor.black
        
        joinDateLabel.sizeToFit()
        joinDateLabel.textColor = UIColor.black
        
        experiencePointsLabel.sizeToFit()
        experiencePointsLabel.textColor = UIColor.black
        
        levelLabel.sizeToFit()
        levelLabel.textColor = UIColor.black
        
        publicTasks.sizeToFit()
    }
    
    func logoutButtonPressed() {
        
    }
    
    func profilePictureTapped() {
        
    }
}
