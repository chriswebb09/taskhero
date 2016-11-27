//
//  AlertView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    let headBanner: UIView = {
        let banner = UIView()
        banner.backgroundColor = UIColor.blue
        return banner
    }()
    
    
//    let alertLabel: UILabel = {
//        let label = UILabel()
//        label.text = "When would you like to complete your task?"
//        return label
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        setupConstraints()
    }
    
    func setupConstraints() {
//        addSubview(alertLabel)
//        alertLabel.translatesAutoresizingMaskIntoConstraints = false
//        alertLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        alertLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//        alertLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        addSubview(headBanner)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        headBanner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        headBanner.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
}
