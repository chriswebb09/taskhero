//
//  ProfileDataCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class ProfileDataCell: UITableViewCell {
    
    static let cellIdentifier = "ProfileDataCell"
    static let dataCellRadius = Constants.Settings.profileDataRadius
    
    var dataCellModel: ProfileDataCellViewModel =  {
        var cellModel = ProfileDataCellViewModel()
        return cellModel
    }()
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        return levelLabel
    }()
    
    lazy var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        return experiencePointsLabel
    }()
    
    lazy var tasksCompletedLabel: UILabel = {
        let taskCompletedLabel = UILabel()
        return taskCompletedLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configureLabels(label:UILabel) {
        label.layer.cornerRadius = ProfileDataCell.dataCellRadius
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.experienceBackground()
        label.textColor = UIColor.black
        label.font = Constants.Font.fontSmall
        label.sizeToFit()
    }
    
    func configureConstraints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.Settings.profileSettingsDataHeight).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.Settings.profileDataLabelWidth).isActive = true
    }
    
    private func setupConstraints() {
        configureLabels(label: levelLabel)
        contentView.addSubview(levelLabel)
        configureConstraints(label: levelLabel)
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.Settings.levelLabelLeftOffset).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        configureLabels(label: experiencePointsLabel)
        contentView.addSubview(experiencePointsLabel)
        configureConstraints(label: experiencePointsLabel)
        experiencePointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        experiencePointsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        configureLabels(label: tasksCompletedLabel)
        contentView.addSubview(tasksCompletedLabel)
        configureConstraints(label: tasksCompletedLabel)
        tasksCompletedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tasksCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.Settings.profileDataRightOffset).isActive = true
    }
    
    func configureCell() {
        levelLabel.text = "Level: \(dataCellModel.level)"
        experiencePointsLabel.text = "Experience: \(String(describing: dataCellModel.experience))"
        tasksCompletedLabel.text = "Tasks completed: \(String(describing: dataCellModel.tasksCompleted))"
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        experiencePointsLabel.text = " "
        levelLabel.text = ""
    }
}
