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
        levelLabel.font = UIFont(name: Constants.helveticaLight, size: 18)
        levelLabel.textAlignment = .center
        return levelLabel
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
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
    }
    
    
    override func prepareForReuse() {
        levelLabel.text = ""
    }
    
}
