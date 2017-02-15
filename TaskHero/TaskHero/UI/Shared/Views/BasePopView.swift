import UIKit

class BasePopView: UIView {
    
    open lazy var headBanner: UIView = {
        let banner = UIView()
        banner.backgroundColor = .black
        return banner
    }()
    
    open lazy var alertLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = .white
        searchLabel.text = "Notification"
        searchLabel.font = Constants.Font.fontNormal
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    private func addHeaderBanner(headBanner:UIView) {
        addSubview(headBanner)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        headBanner.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(self)
        }
    }
    
    private func addAlertLabel(label:UILabel) {
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(self)
        }
    }
    
    open func setupConstraints() {
        addHeaderBanner(headBanner: headBanner)
        addAlertLabel(label:alertLabel)
    }
}
