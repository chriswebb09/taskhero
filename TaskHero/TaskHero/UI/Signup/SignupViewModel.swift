import UIKit

struct SignupViewModel {
    
    var signupTitle: String
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
    
    init(signup: String) {
        self.signupTitle = signup
    }
}
