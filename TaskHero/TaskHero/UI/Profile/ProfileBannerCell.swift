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
    
    // MARK: - UI Elements
    // =========================================================================
    
    var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
}

extension ProfileBannerCell {
    
    // MARK: - Initialization
    // =========================================================================
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Configuring
    // =========================================================================
    
    // Configure constraints
    
    private func setupConstraints() {
        contentView.addSubview(bannerImage)
        
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.center = contentView.center
        bannerImage.widthAnchor.constraint(equalTo:contentView.widthAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: Constants.Settings.profileBannerHeight).isActive = true
    }
    
    // Configure cell UI
    
    func configureCell() {
        layoutSubviews()
        isUserInteractionEnabled = false
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = Constants.Profile.profileHeaderBannerColor
    }
    
    // Prepare for reuse
    
    override func prepareForReuse() {
        bannerImage.image = nil
    }
}
