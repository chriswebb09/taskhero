import UIKit
import SnapKit

final class AppScreenView: UIView {
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    var signupButton: UIButton = {
        let button = ButtonType.system(title:"Register Now",
                                       color: Constants.Color.mainColor.setColor)
        return button.newButton
    }()
    
    var viewDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupLogoImage(logoImageView: logoImageView)
        constraintSetup(views: [viewDivider, loginButton, signupButton])
        setupViewDivider(viewDivider: viewDivider)
        
        let loginButtonOffset = UIScreen.main.bounds.height * AppScreenConstants.loginButtonBottonOffset
        let signInButtonOffset = UIScreen.main.bounds.height * AppScreenConstants.signupButtonTopOffset
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(Constants.Login.loginFieldWidth)
            make.height.equalTo(self).multipliedBy(AppScreenConstants.heightMultiplier)
            make.bottom.equalTo(viewDivider.snp.top).offset(loginButtonOffset)
        }
        
        signupButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(Constants.Login.loginFieldWidth)
            make.height.equalTo(self).multipliedBy(AppScreenConstants.heightMultiplier)
            make.top.equalTo(viewDivider.snp.bottom).offset(signInButtonOffset)
        }
    }
    
    private func setupLogoImage(logoImageView: UIView) {
        
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(AppScreenConstants.logoWidth)
            make.height.equalTo(self).multipliedBy(AppScreenConstants.logoHeight)
            make.centerY.equalTo(self).offset(bounds.height * AppScreenConstants.logoCenterYOffset)
        }
    }
    
    func buttonSetup(buttons: [UIButton]) {
        // Not implemented yet
    }
    
    private func constraintSetup(views: [UIView]) {
        _ = views.map { addSubview($0) }
        _ = views.map { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setupView(view: UIView) {
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(Constants.Login.loginFieldWidth)
            make.height.equalTo(self).multipliedBy(Constants.Login.loginFieldHeight)
        }
    }
    
    private func setupViewDivider(viewDivider: UIView) {
        
        viewDivider.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(Constants.Login.dividerWidth)
            make.height.equalTo(loginButton.snp.height).multipliedBy(Constants.Login.dividerHeight)
            make.centerY.equalTo(self).offset(UIScreen.main.bounds.height * AppScreenConstants.dividerCenterYOffset)
        }
    }
}



