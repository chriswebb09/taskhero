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
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    
    func setupConstraints() {
        contentView.addSubview(bannerImage)
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.center = contentView.center
        bannerImage.widthAnchor.constraint(equalTo:contentView.widthAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    
    override func prepareForReuse() {
        bannerImage.image = nil
    }
}
