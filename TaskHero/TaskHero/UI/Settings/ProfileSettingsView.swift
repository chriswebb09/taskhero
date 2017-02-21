import UIKit

final class ProfileSettingsView: UIView {
    
    var profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.textColor = .black
        profileLabel.text = "User Settings"
        profileLabel.font = Constants.Font.fontLarge
        profileLabel.textAlignment = .center
        profileLabel.layer.masksToBounds = true
        return profileLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Settings.FriendsSetting.friendsHeaderLabelHeight)
            make.height.equalTo(self).multipliedBy(Constants.Dimension.height)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(bounds.height * Constants.Profile.Offset.labelTopOffset)
        }
    }
}
