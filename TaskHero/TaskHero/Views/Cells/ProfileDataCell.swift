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
        levelLabel.textColor = UIColor.black
        levelLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        levelLabel.textAlignment = .left
        return levelLabel
    }()
    
    lazy var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        experiencePointsLabel.textColor = UIColor.black
        experiencePointsLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        experiencePointsLabel.textAlignment = .left
        experiencePointsLabel.sizeToFit()
        experiencePointsLabel.layer.masksToBounds = true
        return experiencePointsLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        contentView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        contentView.addSubview(experiencePointsLabel)
        experiencePointsLabel.translatesAutoresizingMaskIntoConstraints = false
        experiencePointsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        experiencePointsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        experiencePointsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        experiencePointsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80).isActive = true
    }
    
    
    override func prepareForReuse() {
        experiencePointsLabel.text = " "
        levelLabel.text = ""
    }
    
}
