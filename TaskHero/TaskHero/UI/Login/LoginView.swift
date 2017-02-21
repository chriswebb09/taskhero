//
//  LoginView.swift
//  TaskHero
//

import UIKit
import SnapKit

final class LoginView: UIView {
    
    // MARK: UIElements
    
    var editState: Bool = false
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var emailField = TextFieldExtension().emailField("Enter email address") {
        didSet {
            print(emailField.text ?? "No text entered in emailfield")
        }
    }
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login").newButton
        return button
    }()
    
    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
        initialOpacity()
        animated()
    }
    
    // MARK: View Opacity Methods
    
    func initialOpacity() {
        loginButton.layer.opacity = 0
        emailField.layer.opacity = 0
        passwordField.layer.opacity = 0
        logoImageView.layer.opacity = 0
    }
    
    func animatedOpacity() {
        loginButton.layer.opacity = 1
        emailField.layer.opacity = 1
        passwordField.layer.opacity = 1
        logoImageView.layer.opacity = 1
    }
    
    // MARK: Setup
    /* Lays out subviews, adds delegate to textFields, adds selector method to signup button and loginButton add gesture recognizer tap*/
    
    func setupLogin(_ viewController: LoginViewController) {
        layoutSubviews()
        emailField.delegate = viewController
        passwordField.delegate = viewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action: #selector(viewController.dismissKeyboard))
        viewController.view.addGestureRecognizer(tap)
        loginButton.addTarget(viewController, action: #selector(viewController.handleLogin), for: .touchUpInside)
    }
    
    // MARK: - Configuring UI
    
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
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.snp.makeConstraints { make in
            
            make.width.equalTo(self).multipliedBy(0.7)
            make.height.equalTo(self).multipliedBy(0.06)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(self.bounds.height * 0.12)
        }
    }
    
    private func setupConstraints() {
        setupLogoImage()
        
        setupView(view: emailField)
        setupView(view: passwordField)
        setupView(view: loginButton)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(bounds.height * 0.1)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(bounds.height * 0.06)
        }
        
        passwordField.isSecureTextEntry = true
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(bounds.height * 0.1)
        }
    }
    
    // MARK: Animation
    
    func animated() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.animatedOpacity()
        }
    }
    
    func constraintsForInput() {
        
        self.logoImageView.snp.makeConstraints { make in
            make.height.equalTo(self).multipliedBy(0.02)
            make.width.equalTo(self).multipliedBy(0.5)
            make.top.equalTo(self).offset(self.bounds.height * 0.05)
        }
        
        self.emailField.snp.makeConstraints { make in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(self.bounds.height * 0.06)
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordField.snp.bottom).offset(self.bounds.height * 0.04)
        }
    }
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 3, initialSpringVelocity: 0.0,  options: [.curveEaseInOut, .transitionCrossDissolve], animations: { [unowned self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.emailField.layer.borderWidth = 1.2
                self.emailField.font = UIFont(name: "HelveticaNeue" , size: 16)
                self.emailField.textColor =  Constants.Color.backgroundColor.setColor
                
            } }, completion: { _ in
                
                let when = DispatchTime.now() + 0.32
                DispatchQueue.main.asyncAfter(deadline: when) { [unowned self] in
                    
                    self.emailField.layer.borderWidth = 1
                    self.emailField.font = Constants.signupFieldFont
                    self.emailField.textColor = .lightGray
                    self.emailField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
                    self.emailField.layer.borderWidth = Constants.Border.borderWidth
                }
        })
    }
}
