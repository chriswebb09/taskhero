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
    
    fileprivate func setupConstraints() {
        contentView.addSubview(bannerImage)
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.center = contentView.center
        bannerImage.widthAnchor.constraint(equalTo:contentView.widthAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func configureCell() {
        layoutSubviews()
        isUserInteractionEnabled = false
        
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
    }
    
    override func prepareForReuse() {
        bannerImage.image = nil
    }
}
