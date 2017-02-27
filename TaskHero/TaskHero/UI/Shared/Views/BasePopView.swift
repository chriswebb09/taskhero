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
        searchLabel.textAlignment = .center
        searchLabel.font = Constants.Font.fontNormal
        return searchLabel
    }()
    
    private func addHeaderBanner(headBanner:UIView) {
        addSubview(headBanner)
        headBanner.translatesAutoresizingMaskIntoConstraints = false
        
        headBanner.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(PopConstants.heightMultiplier)
        }
    }
    
    private func addAlertLabel(label:UILabel) {
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(PopConstants.heightMultiplier)
        }
    }
    
    open func setupConstraints() {
        addHeaderBanner(headBanner: headBanner)
        addAlertLabel(label:alertLabel)
    }
}
