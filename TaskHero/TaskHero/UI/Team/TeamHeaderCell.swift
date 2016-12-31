//
//  TeamHeaderCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TeamHeaderCellDelegate: class {
    func profilePictureTapped()
}

final class TeamHeaderCell: UITableViewCell {
    
    static let cellIdentifier = "TeamHeaderCell"
    let usernameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupCell()
    }
    
    private func setupConstraints() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    private func setupCell() {
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = UIFont(name: Constants.helveticaLight, size: 30)
        usernameLabel.sizeToFit()
    }
}
