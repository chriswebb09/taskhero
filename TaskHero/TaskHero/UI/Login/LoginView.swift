import UIKit

final class LoginView: UIView {
    
    var editState: Bool = false
    
    var initialLoad: Bool = true
    
    var logoImageView: UIImageView = {
        let image = UIImage(named: "taskherologo2")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var emailField = TextFieldExtension().emailField("Enter email address") {
        didSet {
            print(emailField.text ?? "Email field")
        }
    }
    
    var passwordField: TextFieldExtension = {
        let passwordField = TextFieldExtension().passwordField()
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = ButtonType.login(title: "Login")
        return button.newButton
    }()
    
    var logoTopConstraint: NSLayoutConstraint!
    var logoHeightAnchor: NSLayoutConstraint!
    var logoWidthConstraint: NSLayoutConstraint!
    var emailFieldTopConstraint: NSLayoutConstraint!
    var passwordFieldTopConstraint: NSLayoutConstraint!
    var loginButtonTopConstraint: NSLayoutConstraint!
    
    // MARK: Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        frame = UIScreen.main.bounds
        setupConstraints()
        initialLoad = false
        animatedOpacity()
        animated()
    }
}

extension LoginView {
    
    func animatedOpacity() {
        
        loginButton.layer.opacity = initialLoad == true ? 1 : 0
        emailField.layer.opacity = initialLoad == true ? 1 : 0
        passwordField.layer.opacity = initialLoad == true ? 1 : 0
        logoImageView.layer.opacity = initialLoad == true ? 1 : 0
    }
    
    func animated() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.initialLoad = true
            self?.animatedOpacity()
        }
    }
    
    // Lays out subviews, adds delegate to textFields, adds selector method to signup button and loginButton add gesture recognizer tap
    
    func setupLogin(_ viewController: LoginViewController) {
        layoutSubviews()
        emailField.delegate = viewController
        passwordField.delegate = viewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController,
                                                                 action: #selector(viewController.dismissKeyboard))
        viewController.view.addGestureRecognizer(tap)
        loginButton.addTarget(viewController,
                              action: #selector(viewController.handleLogin),
                              for: .touchUpInside)
    }
    
    // MARK: - Configuring UI
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor,
                                    multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor,
                                     multiplier:Constants.Login.loginFieldHeight).isActive = true
    }
    
    private func setupLogoImage() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        logoWidthConstraint = logoImageView.widthAnchor.constraint(equalTo: widthAnchor)
        logoWidthConstraint.constant = bounds.width * LoginViewConstants.logoWidthMultiplier
        
        logoHeightAnchor = logoImageView.heightAnchor.constraint(equalTo: heightAnchor)
        logoHeightAnchor.constant = bounds.height * LoginViewConstants.logoHeightMultiplier
        
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: topAnchor)
        logoTopConstraint.constant = bounds.height * LoginViewConstants.logoTopMultiplier
        
    }
    
    fileprivate func setupConstraints() {
        setupLogoImage()
        
        setupView(view: emailField)
        emailFieldTopConstraint = emailField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        emailFieldTopConstraint.constant = bounds.height * LoginViewConstants.emailFieldTopConstant
        
        setupView(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                           constant: bounds.height * LoginViewConstants.passwordFieldTopMultiplier).isActive = true
        passwordField.isSecureTextEntry = true
        
        setupView(view: loginButton)
        loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor)
        loginButtonTopConstraint.constant = bounds.height * LoginViewConstants.loginButtonTopConstant
        NSLayoutConstraint.activate([logoTopConstraint, logoWidthConstraint, logoHeightAnchor, emailFieldTopConstraint, loginButtonTopConstraint])
    }
    
}

extension LoginView {
    
    func textInputAnimation() {
        if editState != true {
            UIView.animate(withDuration: 0.5) {
                self.logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                           multiplier: LoginViewConstants.animatedImageViewHeight).constant = self.bounds.height * LoginViewConstants.animatedImageViewHeightMultiplier
                self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                          multiplier: LoginViewConstants.animatedImageViewWidthMultiplier).isActive = true
                self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                        constant: self.bounds.height * LoginViewConstants.animatedImageViewTopOffset).isActive = true
                self.emailField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor,
                                                     constant: self.bounds.height * LoginViewConstants.animatedEmailFieldTopOffset).isActive = true
                self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor,
                                                      constant: self.bounds.height  * LoginViewConstants.animatedLoginButtonTopOffset).isActive = true
                self.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Animation
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 2,
                       delay: 0.0,
                       usingSpringWithDamping: 3,
                       initialSpringVelocity: 0.0,
                       options: [.curveEaseInOut, .transitionCrossDissolve],
                       animations: { [unowned self] in
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            
                            self.emailField.layer.borderWidth = LoginViewConstants.animatedBorderWidth
                            self.emailField.font = UIFont(name: "HelveticaNeue" , size: 16)
                            self.emailField.textColor =  Constants.Color.backgroundColor.setColor
                            
                        } }, completion: { _ in
                            
                            let when = DispatchTime.now() + 0.32
                            DispatchQueue.main.asyncAfter(deadline: when) { [unowned self] in
                                
                                self.emailField.layer.borderWidth = LoginViewConstants.borderWidth
                                self.emailField.font = Constants.signupFieldFont
                                self.emailField.textColor = .lightGray
                                self.emailField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
                                self.emailField.layer.borderWidth = Constants.Border.borderWidth
                                
                            }
        })
    }
    
    func constraintsForInput() {
        logoTopConstraint.constant = bounds.height * LoginViewConstants.Input.logoTopConstant
        logoWidthConstraint.constant = bounds.height * LoginViewConstants.Input.logoWidthConstant
        emailFieldTopConstraint.constant = bounds.height * LoginViewConstants.Input.emailFieldTopConstant
        loginButtonTopConstraint.constant = bounds.height * LoginViewConstants.Input.loginButtonTopConstants
    }
    
}

