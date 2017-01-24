//
//  ProfileDataCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class ProfileDataCell: UITableViewCell {
    
    // MARK: - ProfileDataCell deallocated
    
    deinit {
        print("ProfileDataCell deallocated")
    }
    
    static let cellIdentifier = "ProfileDataCell"
    
    // MARK: - UI Elements and cellModel
    
    lazy var dataCellModel: ProfileDataCellViewModel =  {
        var cellModel = ProfileDataCellViewModel()
        return cellModel
    }()
    
    // Level label - label for User Level - i.e. Task Goat, Task Wizard ect.
    
    lazy var levelLabel: UILabel = {
        let levelLabel = UILabel()
        return levelLabel
    }()
    
    /*
     - Number of experience points for user - by adding together points of tasks completed
     - at this point tasksCompleted means by tasks deleted - will be improved upon
     */
    
    lazy var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        return experiencePointsLabel
    }()
    
    
    // Actual number of tasks completed - deleted - not pointvalue it is the number of tasks
    lazy var tasksCompletedLabel: UILabel = {
        let taskCompletedLabel = UILabel()
        return taskCompletedLabel
    }()
}

extension ProfileDataCell {
    
    // MARK: - Initialization
    // Lays out subviews and calls setup constraints
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Configuration
    /* Called on levelLabel, experiencePointsLabel, tasksCompleted label - sets label to small green ovaly element with black border aligns content in center */
    
    fileprivate func configureLabels(label:UILabel) {
        label.layer.cornerRadius = Constants.Settings.Profile.profileDataRadius
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.experienceBackground()
        label.textColor = UIColor.black
        label.layer.borderWidth = 1
        label.font = Constants.Font.fontSmall
        label.sizeToFit()
    }
    
    // Most likely will be removed
    
    fileprivate func configureConstraints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Adds constraints to labels to also adds experience points labels and tasksComleted labels to contentView
    
    private func addLevelLabel(levelLabel:UILabel) {
        configureLabels(label: levelLabel)
        contentView.addSubview(levelLabel)
        configureConstraints(label: levelLabel)
        
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.Dimension.topOffset).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func addExperiencePointLabel(experiencePointLabel:UILabel) {
        configureLabels(label: experiencePointsLabel)
        contentView.addSubview(experiencePointsLabel)
        configureConstraints(label: experiencePointsLabel)
        experiencePointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        experiencePointsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        experiencePointsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        experiencePointsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func addTasksCompletedLabel(tasksCompletedLabel:UILabel) {
        configureLabels(label: tasksCompletedLabel)
        contentView.addSubview(tasksCompletedLabel)
        configureConstraints(label: tasksCompletedLabel)
        tasksCompletedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tasksCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.Settings.Profile.profileDataRightOffset).isActive = true
        tasksCompletedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        tasksCompletedLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    fileprivate func setupConstraints() {
        addLevelLabel(levelLabel: levelLabel)
        addExperiencePointLabel(experiencePointLabel: experiencePointsLabel)
        addTasksCompletedLabel(tasksCompletedLabel:tasksCompletedLabel)
    }
    
    // configureCell method - called in ParentViewController - in this case ProfileViewController
    
    func configureCell() {
        levelLabel.text = "Level: \(dataCellModel.level)"
        experiencePointsLabel.text = "Experience: \(String(describing: dataCellModel.experience))"
        tasksCompletedLabel.text = "Tasks Completed: \(String(describing: dataCellModel.tasksCompleted))"
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        experiencePointsLabel.text = " "
        levelLabel.text = ""
    }
}
