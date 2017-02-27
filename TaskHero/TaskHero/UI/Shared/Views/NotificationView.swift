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
        searchLabel.textAlignment = .center
        searchLabel.text = "Please try again later."
        searchLabel.font = Constants.Font.fontNormal
        return searchLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headBanner.backgroundColor = .black
        backgroundColor = .white
        setupConstraints()
    }
    
    private func addDataLabel() {
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(bounds.height / 3)
            make.height.equalTo(self).multipliedBy(NotificationConstants.dataLabelHeightMultiplier)
        }
    }
    
    private func addDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.snp.makeConstraints { make in
            make.right.equalTo(self)
            make.width.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(NotificationConstants.doneButtonHeightMultiplier)
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

struct NotificationConstants {
    static let dataLabelHeightMultiplier: CGFloat = 0.25
    static let doneButtonHeightMultiplier: CGFloat = 0.25
}
