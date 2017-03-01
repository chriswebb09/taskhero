import UIKit

struct SignupViewModel {
    let store = UserDataStore.sharedInstance
    var signupTitle: String = "Sign Up"
    var emailAddress: String = ""
    var confirmEmailAddress = ""
    var username: String = ""
    var password: String = ""
    
    var isEnabled: Bool {
        if (confirmEmailAddress == emailAddress) && (password.characters.count >= 6) {
            return true
        }
        return false
    }
    
    var buttonColor: UIColor {
        if isEnabled {
            return Constants.Color.mainColor.setColor
        }
        return .lightGray
    }
    
    func setupSignupView(controller: SignupViewController) {
        controller.signupView.layoutSubviews()
        controller.signupView.emailField.delegate = controller
        controller.signupView.passwordField.delegate = controller
        controller.signupView.loginButton.addTarget(self, action: #selector(controller.signupButtonTapped), for: .touchUpInside)
    }
    
}
