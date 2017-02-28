//
//  ProfileHeaderCell.swift
//  TaskHero
//

import UIKit
import SnapKit

protocol ProfileHeaderCellDelegate: class {
    func profilePictureTapped(sender: UIGestureRecognizer)
}

final class ProfileHeaderCell: BaseCell {
    
    static let cellIdentifier = "ProfileHeaderCell"
    weak var delegate: ProfileHeaderCellDelegate?
    
    var profileHeaderCellModel = ProfileHeaderCellModel()
    
    var joinDateLabel: UILabel = {
        let joinDateLabel = UILabel()
        joinDateLabel.font = Constants.Font.fontLarge
        return joinDateLabel
    }()
    
    var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = Constants.Font.bolderFontLarge
        return usernameLabel
    }()
    
    var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = Constants.Font.fontLarge
        return emailLabel
    }()
    
    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = Constants.Font.fontMedium
        levelLabel.textAlignment = .right
        return levelLabel
    }()
    
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = Constants.Dimension.mainWidth
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    fileprivate func configureLargeLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.Font.fontLarge
        return label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        contentView.layoutIfNeeded()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    private func configureLabel(label:UILabel) {
        label.textColor = .black
        label.textAlignment = .right
        label.sizeToFit()
    }
    
    private func configureConstraints(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(Constants.Dimension.bottomOffset)
        }
    }
    
    private func addConfigures() {
        setupLevelLabel()
        setupEmailLabel()
        setupJoinDateLabel()
        setupUsernameLabel()
        contentView.addSubview(profilePicture)
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        configureLabel(label: usernameLabel)
        configureConstraints(label: usernameLabel)
    }
    
    private func setupLevelLabel() {
        contentView.addSubview(levelLabel)
        configureLabel(label: levelLabel)
        configureConstraints(label: levelLabel)
    }
    
    private func setupEmailLabel() {
        contentView.addSubview(emailLabel)
        configureLabel(label: emailLabel)
        configureConstraints(label: emailLabel)
    }
    
    private func setupJoinDateLabel() {
        contentView.addSubview(joinDateLabel)
        configureLabel(label: joinDateLabel)
        configureConstraints(label: joinDateLabel)
    }
    
    private func addUsernameLabel() {
        
        usernameLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.Dimension.mainHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.Dimension.mainWidth)
            make.top.equalTo(profilePicture.snp.top)
        }
    }
    
    private func addlevelLabel() {
        
        levelLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profilePicture.snp.bottom)
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.Dimension.mainHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.Dimension.mainWidth)
        }
    }
    
    private func addJoinDateLabel() {
        
        joinDateLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(Constants.Dimension.mainHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Constants.Dimension.mainWidth)
            make.bottom.equalTo(contentView.snp.bottom).offset(Constants.Dimension.mainOffset)
        }
    }
    
    private func addProfilePicture() {
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * Constants.Profile.ProfilePicture.profilePictureHeight)
            make.width.equalTo(UIScreen.main.bounds.width * Constants.Profile.ProfilePicture.profilePictureWidth)
            make.top.equalTo(contentView.snp.top).offset(Constants.Profile.Offset.topOffset)
            make.left.equalTo(contentView.snp.left).offset(Constants.Dimension.topOffset)
        }
    }
    
    private func setupConstraints() {
        addConfigures()
        addUsernameLabel()
        addlevelLabel()
        addJoinDateLabel()
        addProfilePicture()
    }
    
    /*
     Public configureCell method - taskes autoHeight parameter of type UIViewAutoresizing - called in ParentViewController
     in this case that is either ProfileViewController or HomeViewController
     */
    
    func configureCell(user: User) {
        configureUI()
        emailLabel.text = user.email
        joinDateLabel.isHidden = true
        usernameLabel.text = user.username
        levelLabel.text = "Level: \(user.level)"
        joinDateLabel.text = "Joined: \(user.joinDate)"
        if UserDataStore.sharedInstance.currentUser.userProfilePic != nil {
            profilePicture.image = UserDataStore.sharedInstance.currentUser.userProfilePic
        } else {
            profilePicture.image = UIImage(named: "defaultUserImage")
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped))
        profilePicture.addGestureRecognizer(tap)
        layoutIfNeeded()
    }
    
    private func configureUI() {
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        profilePicture.isUserInteractionEnabled = true
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width:-0.45, height: 0.4)
        layer.shadowOpacity = 0.4
    }
}

extension ProfileHeaderCell: ProfileHeaderCellDelegate {
    
    // MARK: - Delegate Methods
    
    func profilePictureTapped(sender: UIGestureRecognizer) {
        print("profile pic tapped\n\n\n\n\n\n")
        delegate?.profilePictureTapped(sender: sender)
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = ""
        profilePicture.image = nil
    }
}
