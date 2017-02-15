import UIKit

class AppScreenViewController: UIViewController {
    
    let appScreenView = AppScreenView()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        print("LOGGED IN \(defaults.bool(forKey: "hasLoggedIn"))")
        super.viewDidLoad()
        view.addSubview(appScreenView)
        appScreenView.layoutSubviews()
        appScreenView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        appScreenView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("LOGGED IN \(defaults.bool(forKey: "hasLoggedIn"))")
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension AppScreenViewController {
    
    func loginButtonTapped() {
        navigationController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
