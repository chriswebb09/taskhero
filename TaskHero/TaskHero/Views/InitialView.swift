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
    let logoLabel = UILabel()
    let welcomeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setupConstraints() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalTo:heightAnchor, multiplier: 0.75).isActive = true
        containerView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.85).isActive = true
        
        containerView.addSubview(logoLabel)
        logoLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        logoLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.25).isActive = true
        
        containerView.addSubview(welcomeLabel)
    }
    
    func setupView() {
        logoLabel.font = UIFont(name: Constants.font, size: 20)
    }
}
