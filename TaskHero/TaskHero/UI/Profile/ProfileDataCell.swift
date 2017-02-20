//
//  ProfileDataCell.swift
//  TaskHero
//

import UIKit

protocol ProfileDataCellDelegate: class {
    func userStatsTapped()
}

final class ProfileDataCell: UITableViewCell {
    
    weak var delegate: ProfileDataCellDelegate?
    static let cellIdentifier = "ProfileDataCell"
    
    // MARK: - UI Elements and cellModel
    
    var dataCellModel: ProfileDataCellViewModel =  {
        var cellModel = ProfileDataCellViewModel()
        return cellModel
    }()
    
    // Level label - label for User Level - i.e. Task Goat, Task Wizard ect.
    
    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        return levelLabel
    }()
    
    /* Number of experience points for user - by adding together points of tasks completed
     * at this point tasksCompleted means by tasks deleted - will be improved upon
     */
    
    var experiencePointsLabel: UILabel = {
        let experiencePointsLabel = UILabel()
        return experiencePointsLabel
    }()
    
    // Actual number of tasks completed - deleted - not pointvalue it is the number of tasks
    
    var tasksCompletedLabel: UILabel = {
        let taskCompletedLabel = UILabel()
        return taskCompletedLabel
    }()
    
    var topDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .black
        return divider
    }()
    
    var bottomDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .black
        return divider
    }()
    
    // MARK: - Initialization
    // Lays out subviews and calls setup constraints
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = false
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        let views = [levelLabel, experiencePointsLabel, tasksCompletedLabel, topDivider, bottomDivider]
        setupViewsForConfig(views: views)
        setupConstraints()
    }
}

extension ProfileDataCell {

    // MARK: - Configuration
    /* Called on levelLabel, experiencePointsLabel, tasksCompleted label - 
     * sets label to small green ovaly element with black border aligns content in center */
    
    private func configureLabels(label: UILabel) {
        label.layer.cornerRadius = Constants.Settings.Profile.profileDataRadius
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .experienceBackground()
        label.textColor = .black
        label.layer.borderWidth = 1
        label.font = Constants.Font.fontSmall
        label.sizeToFit()
    }
    
    func setupViewsForConfig(views: [UIView]) {
        _ = views.map { contentView.addSubview($0) }
        _ = views.map { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    // Adds constraints to labels to also adds experience points labels and tasksComleted labels to contentView
    
    private func addLevelLabel(levelLabel:UILabel) {
        configureLabels(label: levelLabel)
        levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.Dimension.topOffset).isActive = true
        levelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        levelLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        levelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func configureDividers(view: UIView) {
        view.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
    }
    
    private func addExperiencePointLabel(experiencePointLabel:UILabel) {
        configureLabels(label: experiencePointsLabel)
        experiencePointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        experiencePointsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        experiencePointsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        experiencePointsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func addTasksCompletedLabel(tasksCompletedLabel:UILabel) {
        configureLabels(label: tasksCompletedLabel)
        tasksCompletedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tasksCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.Settings.Profile.profileDataRightOffset).isActive = true
        tasksCompletedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        tasksCompletedLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    fileprivate func setupConstraints() {
        addLevelLabel(levelLabel: levelLabel)
        addExperiencePointLabel(experiencePointLabel: experiencePointsLabel)
        addTasksCompletedLabel(tasksCompletedLabel:tasksCompletedLabel)
        configureDividers(view: topDivider)
        topDivider.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topDivider.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        configureDividers(view: bottomDivider)
        bottomDivider.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bottomDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension ProfileDataCell {

    // ConfigureCell method - called in ParentViewController - in this case ProfileViewController
    
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
    
    func userStateTapped() {
        delegate?.userStatsTapped()
    }
}
