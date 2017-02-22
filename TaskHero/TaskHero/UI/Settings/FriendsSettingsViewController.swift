import UIKit

final class FriendsSettingsViewController: UIViewController {
    
    let friendsSettingsView = FriendsSettingsView()
    let alertPop = AlertPopover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(friendsSettingsView)
        setupFriendsSettingView()
    }
    
    func setupFriendsSettingView() {
        friendsSettingsView.layoutSubviews()
        friendsSettingsView.searchField.delegate = self
        friendsSettingsView.searchButton.addTarget(self, action: #selector(popup), for: .touchUpInside)
    }
}

extension FriendsSettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func popup() {
        alertPop.showPopView(viewController: self)
        friendsSettingsView.searchField.resignFirstResponder()
        
        alertPop.alertPopView.resultLabel.text = "No results found."
        alertPop.alertPopView.doneButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        alertPop.alertPopView.cancelButton.addTarget(self,action: #selector(dismissButton),for: .touchUpInside)
    }
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
        
        UINavigationController().popViewController(animated: false)
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
}
