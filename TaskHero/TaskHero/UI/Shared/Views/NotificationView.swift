//
//  NotificationView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    let headBanner: UIView = {
        let banner = UIView()
        banner.backgroundColor = UIColor.black
        // banner.backgroundColor = UIColor.blue
        return banner
    }()
    
//    let cancelButton: UIButton = {
//        var button = ButtonType.system(title: "Cancel", color: UIColor.white)
//        var uiElement = button.newButton
//        uiElement.layer.cornerRadius = 0
//        uiElement.backgroundColor = UIColor(red:0.88, green:0.35, blue:0.35, alpha:1.0)
//        return uiElement
//    }()
    
    let doneButton: UIButton = {
        var button = ButtonType.system(title: "Okay", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = UIColor.gray
        //uiElement.backgroundColor = Constants.Login.loginButtonColor
        return uiElement
    }()
    
    lazy var resultLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Please try again later."
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    
    lazy var alertLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.white
        searchLabel.text = "Notification"
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
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
        
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        alertLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        //alertLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: bounds.height / 3).isActive = true
        //alertLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        resultLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        
//        addSubview(cancelButton)
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        cancelButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        //cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
}
