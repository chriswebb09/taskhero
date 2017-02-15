import UIKit
import SnapKit

class SignupView: UIView {
    
    var registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = Constants.Color.backgroundColor
        registerLabel.text = "Don't have an account?"
        registerLabel.font = Constants.Font.fontLarge
        registerLabel.textAlignment = .center
        return registerLabel
    }()
    
    var usernameField: TextFieldExtension = {
        let usernameField = TextFieldExtension().emailField("Choose a username")
        return usernameField
    }()
    
    var emailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Enter email address")
        return emailField
    }()
    
    var confirmEmailField: TextFieldExtension = {
        let emailField = TextFieldExtension().emailField("Confirm email address")
        return emailField
    }()
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Sign Up")
        return button.newButton
    }()
    
}

extension SignupView {

    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Login.loginFieldWidth)
            make.height.equalTo(self).multipliedBy(Constants.Login.loginFieldHeight)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupLogoImage() {
        addSubview(registerLabel)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        registerLabel.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Logo.logoImageWidth)
            make.height.equalTo(self).multipliedBy(Constants.Logo.logoImageHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(bounds.height * 0.08)
        }
    }
    
    private func setupViewDivider(viewDivider: UIView) {
        addSubview(viewDivider)
        viewDivider.translatesAutoresizingMaskIntoConstraints = false
        viewDivider.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(Constants.Login.dividerWidth)
            make.height.equalTo(self).multipliedBy(Constants.Login.dividerHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(loginButton.snp.bottom).offset(bounds.height * Constants.Login.loginElementSpacing)
        }
    }
    
    fileprivate func setupConstraints() {
        setupLogoImage()
        setupView(view: usernameField)
        usernameField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: bounds.height * 0.065).isActive = true
        setupView(view: emailField)
        emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        setupView(view: confirmEmailField)
        confirmEmailField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        setupView(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: confirmEmailField.bottomAnchor, constant: bounds.height * 0.042).isActive = true
        passwordField.isSecureTextEntry = true
        setupView(view: loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: bounds.height * 0.085).isActive = true
        
    }
}

