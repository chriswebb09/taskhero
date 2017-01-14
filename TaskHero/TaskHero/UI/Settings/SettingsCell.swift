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
    
    
    // ==================================
    // MARK: - Deallocation from memory
    // =================================

    deinit {
        print("SettingsCell deallocated")
    }
    
    // ==============================
    // MARK: - UIElement
    // ==============================
    
    lazy var settingLabel: UILabel = {
        let textView = UILabel()
        textView.textColor = UIColor.white
        textView.font = Constants.Font.fontNormal
        textView.textAlignment = .center
        textView.layer.masksToBounds = true
        return textView
    }()
}

extension SettingsCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // =====================================
    // MARK: - Configure constraints
    // =====================================
    
    private func setupConstraints() {
        contentView.backgroundColor = UIColor.settingsBackground()
        contentView.addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier:Constants.Dimension.height).isActive = true
        settingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        settingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configureCell(setting: SettingsCellViewModel) {
        layoutSubviews()
        settingLabel.text = setting.setting
    }
    
}


extension SettingsCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingLabel.text = ""
    }
}
