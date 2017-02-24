import UIKit

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
    
    var viewModel = LoginViewModel()
    
    
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
        initialOpacity()
        animated()
    }
}

extension LoginView {
    
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
    
    func animated() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.animatedOpacity()
        }
    }
    
    /* Lays out subviews, adds delegate to textFields, adds selector method to signup button and loginButton add gesture recognizer tap*/
    
    func setupLogin(_ viewController: LoginViewController) {
        layoutSubviews()
        viewController.edgesForExtendedLayout = []
        loginButton.isEnabled = false
        loginButton.backgroundColor = viewModel.enableColor
    }
    
    // MARK: - Configuring UI
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Login.loginFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier:Constants.Login.loginFieldHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupLogoImage() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoWidthConstraint = logoImageView.widthAnchor.constraint(equalTo: widthAnchor)
        logoWidthConstraint.constant = bounds.width * LoginConstants.logoImageWidth
        logoHeightAnchor = logoImageView.heightAnchor.constraint(equalTo: heightAnchor)
        logoHeightAnchor.constant = bounds.height * LoginConstants.logoImageHeight
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: topAnchor)
        logoTopConstraint.constant = bounds.height * LoginConstants.logoImageTopOffset
        
    }
    
    fileprivate func setupConstraints() {
        setupLogoImage()
        setupView(view: emailField)
        emailFieldTopConstraint = emailField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        emailFieldTopConstraint.constant = bounds.height * LoginConstants.emailFieldTopOffset
        
        setupView(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: bounds.height * LoginConstants.passwordFieldTopOffset).isActive = true
        passwordField.isSecureTextEntry = true
        setupView(view: loginButton)
        loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor)
        loginButtonTopConstraint.constant = bounds.height * LoginConstants.loginButtonTopOffset
        NSLayoutConstraint.activate([logoTopConstraint, logoWidthConstraint, logoHeightAnchor, emailFieldTopConstraint, loginButtonTopConstraint])
    }
    
}

extension LoginView {
    
    func textInputAnimation() {
        if editState != true {
            UIView.animate(withDuration: 0.5) {
                self.logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).constant = self.bounds.height * -0.02
                self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
                self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * 0.05).isActive = true
                self.emailField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: self.bounds.height * 0.06).isActive = true
                self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: self.bounds.height  * 0.04).isActive = true
                self.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Animation
    
    func textFieldAnimation() {
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 3, initialSpringVelocity: 0.0,  options: [.curveEaseInOut, .transitionCrossDissolve], animations: { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.emailField.layer.borderWidth = LoginConstants.textFieldAnimationWidth
                self.emailField.font = UIFont(name: "HelveticaNeue" , size: LoginConstants.fontSize)
                self.emailField.textColor =  Constants.Color.backgroundColor.setColor
            } }, completion: { _ in
                let when = DispatchTime.now() + LoginConstants.textFieldAnimationDelay
                DispatchQueue.main.asyncAfter(deadline: when) { [unowned self] in
                    self.emailField.layer.borderWidth = 1
                    self.emailField.font = Constants.signupFieldFont
                    self.emailField.textColor = .lightGray
                    self.emailField.layer.borderColor = Constants.Color.backgroundColor.setColor.cgColor
                    self.emailField.layer.borderWidth = Constants.Border.borderWidth
                }
        })
    }
    
    func constraintsForInput() {
        logoTopConstraint.constant = bounds.height * LoginConstants.Input.logoTopOffset
        logoWidthConstraint.constant = bounds.height * LoginConstants.Input.logoWidth
        emailFieldTopConstraint.constant = bounds.height * LoginConstants.Input.emailFieldTopOffset
        loginButtonTopConstraint.constant = bounds.height * LoginConstants.Input.loginButtonTopOffset
    }
    
}


