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
        return banner
    }()
    
    let cancelButton: UIButton = {
        var button = ButtonType.system(title: "Cancel", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = UIColor(red:0.88, green:0.35, blue:0.35, alpha:1.0)
        return uiElement
    }()
    
    let doneButton: UIButton = {
        var button = ButtonType.system(title: "Add", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = Constants.Login.loginButtonColor
        return uiElement
    }()
    
    lazy var resultLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.text = "Results"
        searchLabel.textColor = UIColor.black
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    
    lazy var alertLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Find Your Friends"
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        backgroundColor = UIColor.white
    }
    
    func configureConstaints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func setupConstraints() {
        addSubview(doneButton)
        addSubview(alertLabel)
        addSubview(headBanner)
        addSubview(resultLabel)
        addSubview(cancelButton)
        configureConstaints(label: alertLabel)
        configureConstaints(label: resultLabel)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        headBanner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        headBanner.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        alertLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: bounds.height / 3).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    }
}
