import UIKit

struct SettingsCellViewModel {
    var setting: String
    init(_ setting: String) {
        self.setting = setting
    }
  //  var settingsType: Settings
//    init(_ setting: String, type: Settings) {
//        self.setting = setting
//        self.settingsType = type
//    }
}


enum Settings {
    case editProfile, friends, notifications
}
