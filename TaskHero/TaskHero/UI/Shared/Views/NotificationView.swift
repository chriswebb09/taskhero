//
//  NotificationView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NotificationView: BasePopView {
    
    lazy var doneButton: UIButton = {
        var button = ButtonType.system(title: "Okay", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = UIColor.gray
        return uiElement
    }()
    
    lazy var dataLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Please try again later."
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
}

extension NotificationView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headBanner.backgroundColor = UIColor.black
        backgroundColor = UIColor.white
        setupConstraints()
    }
    
    override func setupConstraints() {
        addSubview(dataLabel)
        addSubview(doneButton)
        super.setupConstraints()
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dataLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        dataLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        dataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: bounds.height / 3).isActive = true
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
}
