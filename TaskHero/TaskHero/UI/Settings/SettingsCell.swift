//
//  SettingsCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    static let cellIdentifier = "SettingsCell"
    
    dynamic let settingLabel: UILabel = {
        let textView = UILabel()
        textView.textColor = UIColor.white
        textView.font = Constants.Font.fontNormal
        textView.textAlignment = .center
        textView.layer.masksToBounds = true
        return textView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    fileprivate func setupConstraints() {
        contentView.backgroundColor = UIColor.settingsBackground()
        contentView.addSubview(settingLabel)
        
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:Constants.Settings.labelHeight).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        settingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
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
