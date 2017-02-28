import UIKit
import SnapKit

class SignupView: UIView {
    
    var registerLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.textColor = Constants.Color.backgroundColor.setColor
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
    
    private func setupConstraints() {
        setupLogoImage()
        setupView(view: usernameField)
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(bounds.height * 0.062)
        }
        setupView(view: emailField)
        emailField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(bounds.height * 0.042)
        }
        setupView(view: confirmEmailField)
        confirmEmailField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(bounds.height * 0.042)
        }
        setupView(view: passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(confirmEmailField.snp.bottom).offset(bounds.height * 0.042)
        }
        passwordField.isSecureTextEntry = true
        setupView(view: loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(bounds.height * 0.085)
        }
    }
}

