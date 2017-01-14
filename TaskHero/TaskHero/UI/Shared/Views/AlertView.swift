//
//  AlertView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class AlertView: UIView {
    
    deinit {
        print("AlertView deallocated from memory")
    }
    
    public lazy var headBanner: UIView = {
        let banner = UIView()
        banner.backgroundColor = UIColor.lightGray
        return banner
    }()
    
    public lazy var cancelButton: UIButton = {
        var button = ButtonType.system(title: "Cancel", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = Constants.Alert.CancelButton.cancelButtonColor
        return uiElement
    }()
    
    public lazy var doneButton: UIButton = {
        var button = ButtonType.system(title: "Add", color: UIColor.white)
        var uiElement = button.newButton
        uiElement.layer.cornerRadius = 0
        uiElement.backgroundColor = Constants.Color.mainColor
        return uiElement
    }()
    
    public lazy var resultLabel: UILabel = {
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
}

extension AlertView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        backgroundColor = UIColor.white
    }
    
    fileprivate func configureConstaints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
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
        headBanner.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        headBanner.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        alertLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 3).isActive = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Alert.CancelButton.cancelButtonWidth).isActive = true
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Dimension.mainHeight).isActive = true
        doneButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Alert.CancelButton.cancelButtonWidth).isActive = true
    }
}
