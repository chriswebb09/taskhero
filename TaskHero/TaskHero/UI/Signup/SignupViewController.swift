import UIKit
import Firebase

final class SignupViewController: UIViewController, UITextFieldDelegate {
    
    let store = UserDataStore.sharedInstance
    let signupView = SignupView()
    let signupViewModel = SignupViewModel()
    var emailInvalidated = false
    let CharacterLimit = 11
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signupView)
        signupView.layoutSubviews()
        edgesForExtendedLayout = []
        signupViewModel.setupSignupView(controller: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
}

// MARK: - UITextfield Delegate Methods

extension SignupViewController {
    
    /*
     Checks for character length (implemented for username length) if characters exceed allowed range,
     text field will no longer except new characters
     */
    
    func signupLogic(email: String, password: String, username: String, loadingView: LoadingView) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                loadingView.hideActivityIndicator(viewController: self)
                print(error ?? "unable to get specific error")
                return
            }
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let newUser = User.createUser(uid: uid, username: username, email: email)
            self.store.setupUser(user: newUser)
            SharedMethods.loadTabBar(tabBar: TabBarController())
        }
    }
    
    
    func signupButtonTapped() {
        if let emailText = signupView.emailField.text, let passwordText = signupView.passwordField.text, let userNameText = signupView.usernameField.text {
            signupLogic(email: emailText, password: passwordText, username: userNameText, loadingView: LoadingView())
        }
    }
    
    // Checks text for valid email format and returns bool based on result
    
    func validateEmailInput(email:String, confirm:String) -> Bool {
        let emailLower = email.lowercased()
        let confirmLower = confirm.lowercased()
        if (email.isValidEmail()) && (emailLower == confirmLower) { return true } else { emailInvalidated = true; return false }
    }
    
    // Checks that text has more than five characters / animates UITextField to blue color if true.
    
    func checkTextField(_ textField: UITextField) {
        if let textFieldText = textField.text {
            if textFieldText.characters.count > 5 {
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: { textField.layer.borderColor = UIColor.blue.cgColor },
                               completion: nil)
            }
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
