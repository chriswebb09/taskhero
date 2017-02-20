import UIKit
import SnapKit

typealias completion = () -> Void

final class InitView: UIView {
    
    var animationDuration: Double = 0.8
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        var loginButton = button.newButton
        loginButton.isHidden = true
        return loginButton
    }()
    
    var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now", color:Constants.Color.backgroundColor.setColor)
        var signupButton = button.newButton
        signupButton.isHidden = true
        return signupButton
    }()
    
    var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.isHidden = true
        return view
    }()
    
    // MARK: - Configure
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Logo.logoImageWidth)
            make.height.equalTo(self).multipliedBy(Constants.Logo.logoImageHeight)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    // MARK: - Animation
    func zoomAnimation(_ handler: completion? = nil) {
        let duration: TimeInterval = animationDuration * 0.5
        UIView.animate(withDuration: duration, animations:{ [weak self] in
            if let zoom = self?.zoomOut() {
                self?.logoImageView.transform = zoom
            }
            self?.alpha = 0 }, completion: { finished in
                DispatchQueue.main.async {
                    let appScreenVC = UINavigationController(rootViewController:AppScreenViewController())
                    weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.window?.rootViewController = appScreenVC
                }
                handler?()
        })
    }
    
    private func zoomOut() -> CGAffineTransform {
        let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 05, y: 05)
        return zoomOutTranform
    }
}
