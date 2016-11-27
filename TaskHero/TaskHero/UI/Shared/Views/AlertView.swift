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
        banner.backgroundColor = UIColor.lightGray
       // banner.backgroundColor = UIColor.blue
        return banner
    }()
    
    
//    let alertLabel: UILabel = {
//        let label = UILabel()
//        label.text = "When would you like to complete your task?"
//        return label
//    }()
    
    let cancelButton: UIButton = {
        var button = ButtonType.system(title: "Cancel", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = UIColor.red
        return uiElement
    }()
    
    let doneButton: UIButton = {
        var button = ButtonType.system(title: "Add", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = UIColor.blue
        return uiElement
    }()
    
    
    lazy var alertLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
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
        
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        alertLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        //cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        //doneButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        //cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
//        addSubview(cancelButton)
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        cancelButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: bounds.height * 0.2).isActive = true
//        cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true

        
        
    }
}
