//
//  ProfilePictureView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfilePictureView: UIView {
    
    let profilePicture = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    fileprivate func setupConstraints() {
        addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Dimension.width).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.height).isActive = true
    }
    
    func setupView() {
        //profilePicture.backgroundColor = UIColor.blue
    }
}
