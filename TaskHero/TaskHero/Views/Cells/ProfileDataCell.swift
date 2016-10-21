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
        levelLabel.backgroundColor = UIColor(red:0.29, green:0.85, blue:0.39, alpha:1.0)
        levelLabel.textColor = UIColor.black
        levelLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        levelLabel.textAlignment = .center
        levelLabel.sizeToFit()
        levelLabel.layer.cornerRadius = 4
        levelLabel.layer.masksToBounds = true
        return levelLabel
    }()
    
    lazy var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        experiencePointsLabel.textColor = UIColor.black
        experiencePointsLabel.backgroundColor = UIColor(red:0.29, green:0.85, blue:0.39, alpha:1.0)
        experiencePointsLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        experiencePointsLabel.textAlignment = .center
        experiencePointsLabel.sizeToFit()
        experiencePointsLabel.layer.cornerRadius = 4
        experiencePointsLabel.layer.masksToBounds = true
        return experiencePointsLabel
    }()
    
    lazy var tasksCompletedLabel: UILabel = {
        let taskCompletedLabel = UILabel()
        taskCompletedLabel.backgroundColor = UIColor(red:0.29, green:0.85, blue:0.39, alpha:1.0)
        taskCompletedLabel.textColor = UIColor.black
        taskCompletedLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        taskCompletedLabel.textAlignment = .center
        taskCompletedLabel.layer.cornerRadius = 4
        taskCompletedLabel.sizeToFit()
        taskCompletedLabel.layer.masksToBounds = true
        return taskCompletedLabel
    }()
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        //contentView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        contentView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        contentView.addSubview(experiencePointsLabel)
        experiencePointsLabel.translatesAutoresizingMaskIntoConstraints = false
        experiencePointsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        experiencePointsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        //experiencePointsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        experiencePointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        experiencePointsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //experiencePointsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        
        contentView.addSubview(tasksCompletedLabel)
        tasksCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksCompletedLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        tasksCompletedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        //tasksCompletedLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        tasksCompletedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tasksCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        // tasksCompletedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
    }
    
    
    override func prepareForReuse() {
        experiencePointsLabel.text = " "
        levelLabel.text = ""
    }
    
}
