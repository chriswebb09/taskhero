import UIKit

struct SettingsCellViewModel {
    var setting: String
    init(_ setting: String) {
        self.setting = setting
    }
}

enum Settings {
    case editProfile, friends, notifications
}

protocol Hiddable {
    func hide(view:UIView)
}

extension Hiddable {
    func hide(view:UIView, viewController:UIViewController) {
        print("Not implemented")
    }
}
