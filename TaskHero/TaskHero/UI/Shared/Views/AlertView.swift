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
        // banner.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height * 0.25)
        return banner
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        //backgroundColor = UIColor.lightGray
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
