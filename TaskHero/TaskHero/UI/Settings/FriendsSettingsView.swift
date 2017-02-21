import UIKit

final class FriendsSettingsView: UIView {
    
    var friendsHeaderLabel: UILabel = {
        let friendsHeaderLabel = UILabel()
        friendsHeaderLabel.textColor = .black
        friendsHeaderLabel.text = "Add Friends"
        friendsHeaderLabel.font = Constants.Font.fontLarge
        friendsHeaderLabel.textAlignment = .center
        friendsHeaderLabel.layer.masksToBounds = true
        return friendsHeaderLabel
    }()
    
    var searchField: TextFieldExtension = {
        let searchField = TextFieldExtension()
        searchField.placeholder = "Search by email"
        searchField.font = Constants.signupFieldFont
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchField.layer.borderWidth = Constants.Border.borderWidth
        return searchField
    }()
    
    var searchButton: UIButton = {
        var searchButton = UIButton()
        searchButton.layer.borderWidth = Constants.Border.borderWidth
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = Constants.Color.buttonColor.setColor
        searchButton.layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        return searchButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func configureView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Settings.FriendsSetting.friendsHeaderLabelHeight)
            make.height.equalTo(self).multipliedBy(0.07)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupConstraints() {
        configureView(view: friendsHeaderLabel)
        friendsHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(bounds.height * Constants.Settings.FriendsSetting.friendsHeaderLabelTopOffset)
        }
        configureView(view: searchField)
        searchField.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(Constants.Dimension.mainOffset)
            make.centerY.equalTo(self).offset(-bounds.height * Constants.Settings.centerYOffset)
        }
        configureView(view: searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(bounds.height * Constants.Settings.centerYOffset)
        }
    }
}
