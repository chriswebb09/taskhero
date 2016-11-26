//
//  ProfileDataCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileDataCell: UITableViewCell {

    static let cellIdentifier = "ProfileDataCell"
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.backgroundColor = UIColor.experienceBackground()
        levelLabel.textColor = UIColor.black
        levelLabel.font = Constants.Font.fontSmall
        levelLabel.textAlignment = .center
        levelLabel.sizeToFit()
        levelLabel.layer.cornerRadius = 4
        levelLabel.layer.masksToBounds = true
        return levelLabel
    }()
    
    lazy var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        experiencePointsLabel.textColor = UIColor.black
        experiencePointsLabel.backgroundColor = UIColor.experienceBackground()
        experiencePointsLabel.font = Constants.Font.fontSmall
        experiencePointsLabel.textAlignment = .center
        experiencePointsLabel.sizeToFit()
        experiencePointsLabel.layer.cornerRadius = 4
        experiencePointsLabel.layer.masksToBounds = true
        return experiencePointsLabel
    }()
    
    lazy var tasksCompletedLabel: UILabel = {
        let taskCompletedLabel = UILabel()
        taskCompletedLabel.backgroundColor = UIColor.experienceBackground()
        taskCompletedLabel.textColor = UIColor.black
        taskCompletedLabel.font = Constants.Font.fontSmall
        taskCompletedLabel.textAlignment = .center
        taskCompletedLabel.layer.cornerRadius = 4
        taskCompletedLabel.sizeToFit()
        taskCompletedLabel.layer.masksToBounds = true
        return taskCompletedLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(experiencePointsLabel)
        experiencePointsLabel.translatesAutoresizingMaskIntoConstraints = false
        experiencePointsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        experiencePointsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        experiencePointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        experiencePointsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(tasksCompletedLabel)
        tasksCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksCompletedLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        tasksCompletedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        tasksCompletedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tasksCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
    func configureCell(user:User) {
        levelLabel.text = "Level: \(user.level)"
        experiencePointsLabel.text = "Experience: \(String(describing: user.experiencePoints))"
        tasksCompletedLabel.text = "Tasks completed: \(String(describing: user.numberOfTasksCompleted))"
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        experiencePointsLabel.text = " "
        levelLabel.text = ""
    }
}
