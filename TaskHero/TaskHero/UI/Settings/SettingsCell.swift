//
//  SettingsCell.swift
//  TaskHero
//

import UIKit
import SnapKit

final class SettingsCell: BaseCell {
    
    static let cellIdentifier = "SettingsCell"
    
    var settingLabel: UILabel = {
        let textView = UILabel()
        textView.textColor = .white
        textView.textAlignment = .center
        textView.layer.masksToBounds = true
        textView.font = Constants.Font.fontNormal
        return textView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Configure constraints
    
    fileprivate func setupConstraints() {
        contentView.backgroundColor = .settingsBackground
        contentView.addSubview(settingLabel)
        settingsLabelSetup()
    }
    
    func settingsLabelSetup() {
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.Dimension.height)
        }
    }
    
    func configureCell(setting: SettingsCellViewModel) {
        layoutSubviews()
        settingLabel.text = setting.setting
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingLabel.text = ""
    }
}
