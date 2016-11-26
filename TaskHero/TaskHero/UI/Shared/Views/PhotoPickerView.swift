//
//  PhotoPickerView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PhotoPickerView: UIView {
    
    let headBanner: UIView = {
        let banner = UIView()
        banner.backgroundColor = UIColor.babyBlueColor()
        return banner
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(headBanner)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        headBanner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true 
        headBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        headBanner.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
}
