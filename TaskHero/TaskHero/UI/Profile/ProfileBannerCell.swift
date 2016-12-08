//
//  ProfileBannerCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileBannerCell: UITableViewCell {
    
    static let cellIdentifier = "ProfileBannerCell"
    
    var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
}

extension ProfileBannerCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    fileprivate func setupConstraints() {
        contentView.addSubview(bannerImage)
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.center = contentView.center
        bannerImage.widthAnchor.constraint(equalTo:contentView.widthAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: Constants.Settings.profileBannerHeight).isActive = true
    }
    
    func configureCell() {
        layoutSubviews()
        isUserInteractionEnabled = false
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = Constants.Profile.profileHeaderBannerColor
    }
    
    override func prepareForReuse() {
        bannerImage.image = nil
    }
}
