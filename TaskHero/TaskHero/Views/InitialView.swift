//
//  InitialView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class InitialView: UIView {
    
    let containerView = UIView()
    let logoLabel = UIImageView()
    let welcomeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo:heightAnchor, multiplier: 0.75).isActive = true
        containerView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        
        containerView.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        logoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        logoLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08).isActive = true
        containerView.bringSubview(toFront: logoLabel)
    }
    
    func setupView() {
        logoLabel.image = UIImage(named: "logo")
        welcomeLabel.font = UIFont(name: Constants.font, size: 20)
    }
}
