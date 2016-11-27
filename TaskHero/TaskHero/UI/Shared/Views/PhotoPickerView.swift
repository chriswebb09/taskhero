//
//  PhotoPickerView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MobileCoreServices

class PhotoPickerView: UIView {
    
    let button: UIButton = {
        let button = ButtonType.system(title: "Change Profile Picture", color: UIColor.black)
        return button.newButton
    }()
    
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
    
    fileprivate func setupConstraints() {
        addSubview(headBanner)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        headBanner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true 
        headBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        headBanner.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.Login.loginFieldWidth).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
    }
    
}
