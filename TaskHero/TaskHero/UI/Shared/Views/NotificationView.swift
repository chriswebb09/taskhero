import UIKit
import SnapKit

final class NotificationView: BasePopView {

    var doneButton: UIButton = {
        var button = ButtonType.system(title: "Okay", color: .white).newButton
        button.layer.cornerRadius = 0
        button.backgroundColor = .gray
        return button
    }()
    
    var dataLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = .black
        searchLabel.text = "Please try again later."
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headBanner.backgroundColor = .black
        backgroundColor = .white
        setupConstraints()
    }
}

extension NotificationView {
    
    private func addDataLabel() {
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(self)
            make.top.equalTo(self).offset(bounds.height / 3)
        }
    }
    
    private func addDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.snp.makeConstraints { make in
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(self)
        }
    }
    
    override func setupConstraints() {
        addSubview(dataLabel)
        addSubview(doneButton)
        super.setupConstraints()
        addDataLabel()
        addDoneButton()
    }
}
