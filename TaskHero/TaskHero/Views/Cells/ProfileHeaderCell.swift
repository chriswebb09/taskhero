//
//  ProfileHeaderCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

//
//  ProfileHeaderCell.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit

protocol ProfileHeaderCellDelegate: class {
    func profilePictureTapped()
}

class ProfileHeaderCell: UITableViewCell {
    
    static let cellIdentifier = "ProfileHeaderCell"
    
    lazy var usernameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.black
        nameLabel.layer.masksToBounds = true
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    var profilePicture = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupCell()
    }
    
    func setupConstraints() {
        
        contentView.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        profilePicture.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func setupCell() {
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = UIFont(name: Constants.helveticaLight, size: 30)
        usernameLabel.sizeToFit()
        profilePicture.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = ""
        profilePicture.image = nil
    }
}
