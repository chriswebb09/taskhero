import UIKit

final class InitialViewController: UIViewController {
    
    let initView = InitView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(initView)
        view.backgroundColor = .white
        initView.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true 
        let when = DispatchTime.now() + 0.5 //
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.initView.zoomAnimation({
                print("Animating")
            })
        }
    }
    
}

extension InitialViewController {
    func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: false)
    }
    
    func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: false)
    }
}
