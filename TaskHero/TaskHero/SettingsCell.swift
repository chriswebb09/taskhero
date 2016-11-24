//
//  SettingsCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    static let cellIdentifier = "SettingsCell"

    let settingLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0)
        textView.textColor = UIColor.white
        textView.layer.cornerRadius = 2
        textView.font = UIFont(name: Constants.helveticaLight, size: 18)
        textView.textAlignment = .center
        textView.layer.masksToBounds = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        contentView.addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        settingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        settingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configureCell(setting:String) {
        layoutSubviews()
        settingLabel.text = setting
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingLabel.text = ""
    }
}
