//
//  ProfileBannerCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileBannerCellDelegate: class {
    func logoutButtonPressed()
    func profilePictureTapped()
}

class ProfileBannerCell: UITableViewCell {
    
    weak var delegate: ProfileBannerCellDelegate?
    
    static let cellIdentifier = "ProfileBannerCell"
    
    var userNameLabel = UILabel()
    
    var bannerImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView = UIView()
        //backgroundView?.frame = frame
        backgroundView?.frame = contentView.frame
        setupConstraints()
        setupCell()
    }
    
    func setupConstraints() {
        contentView.addSubview(userNameLabel)
        //  userNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25).isActive = true
        
        //userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView?.addSubview(bannerImageView)
        //backgroundView?.backgroundColor = UIColor.purple
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.center = contentView.center
        bannerImageView.heightAnchor.constraint(equalTo:backgroundView!.heightAnchor).isActive = true
        bannerImageView.widthAnchor.constraint(equalTo:backgroundView!.widthAnchor).isActive = true
        // bannerImageView.heightAnchor.constraint(equalTo: (backgroundView?.heightAnchor)!).isActive = true
        // bannerImageView.widthAnchor.constraint(equalTo: (backgroundView?.widthAnchor)!).isActive = true
    }
    
    func setupCell() {
        userNameLabel.font = UIFont(name: Constants.font, size: 40)
        userNameLabel.textColor = UIColor.black
        userNameLabel.sizeToFit()
        //userNameLabel.textAlignment = .center
        
    }
    
}
