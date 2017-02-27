//
//  ProfileDataCell.swift
//  TaskHero
//

import UIKit
import SnapKit

protocol ProfileDataCellDelegate: class {
    func userStatsTapped()
}

final class ProfileDataCell: BaseCell {
    
    weak var delegate: ProfileDataCellDelegate?
    static let cellIdentifier = "ProfileDataCell"
    
    // MARK: - UI Elements and cellModel
    
    var dataCellModel: ProfileDataCellViewModel =  {
        var cellModel = ProfileDataCellViewModel()
        return cellModel
    }()
    
    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        return levelLabel
    }()
    
    /*
     Number of experience points for user - by adding together points of tasks completed
     at this point tasksCompleted means by tasks deleted - will be improved upon
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = false
        setupContentView()
        let views = [levelLabel,
                     experiencePointsLabel,
                     tasksCompletedLabel,
                     topDivider,
                     bottomDivider]
        setupViewsForConfig(views: views)
        setupConstraints()
    }
    
    private func setupContentView() {
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
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
    
    /* Adds constraints to labels to also adds experience points labels and tasksComleted labels to contentView */
    
    private func addLevelLabel(levelLabel:UILabel) {
        configureLabels(label: levelLabel)
        
        levelLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(Constants.Dimension.topOffset)
            
            make.width.equalTo(contentView.snp.width).multipliedBy(ProfileDataCellConstants.widthMultiplier)
            make.height.equalTo(contentView.snp.height).multipliedBy(ProfileDataCellConstants.heightMultiplier)
        }
    }
    
    private func configureDividers(view: UIView) {
        view.snp.makeConstraints { make in
            
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height).multipliedBy(ProfileDataCellConstants.dividerHeightMultiplier)
        }
    }
    
    private func addExperiencePointLabel(experiencePointLabel:UILabel) {
        configureLabels(label: experiencePointsLabel)
        
        experiencePointLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            
            make.width.equalTo(contentView.snp.width).multipliedBy(ProfileDataCellConstants.widthMultiplier)
            make.height.equalTo(contentView.snp.height).multipliedBy(ProfileDataCellConstants.heightMultiplier)
        }
    }
    
    private func addTasksCompletedLabel(tasksCompletedLabel:UILabel) {
        configureLabels(label: tasksCompletedLabel)
        
        tasksCompletedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            
            make.width.equalTo(contentView.snp.width).multipliedBy(ProfileDataCellConstants.widthMultiplier)
            make.right.equalTo(contentView.snp.right).offset(Constants.Settings.Profile.profileDataRightOffset)
            make.height.equalTo(contentView.snp.height).multipliedBy(ProfileDataCellConstants.heightMultiplier)
        }
    }
    
    private func setupConstraints() {
        addLevelLabel(levelLabel: levelLabel)
        addExperiencePointLabel(experiencePointLabel: experiencePointsLabel)
        addTasksCompletedLabel(tasksCompletedLabel:tasksCompletedLabel)
        
        configureDividers(view: topDivider)
        topDivider.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        configureDividers(view: bottomDivider)
        bottomDivider.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    /* ConfigureCell method - called in ParentViewController - in this case ProfileViewController */
    
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
