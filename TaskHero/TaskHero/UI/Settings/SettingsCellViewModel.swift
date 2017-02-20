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
