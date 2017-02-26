import UIKit

class DataPeristence {
    
    static let shared = DataPeristence()
    
    let defaults = UserDefaults.standard
    
    func hasLoggedIn() {
        let hasLoggedIn = defaults.bool(forKey: "hasLoggedIn")
        let user = defaults.data(forKey: "currentUser")
        if hasLoggedIn {
            print("LOGGED IN")
        }
    }
    
    /* Sets has logged in key for UserDefaults */
    
    func setLoggedInKey(userState: Bool) {
        defaults.set(userState, forKey: "hasLoggedIn")
        defaults.synchronize()
    }
    
    /* Incomplete - set currentUser and tasks on local storage after log in to mitigate constant log in fatigue */
    
    func setUserData(user: User) {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: user), forKey: "currentUser")
        defaults.synchronize()
    }
    
    /* incomplete - when finished method should remove currentUser and tasks from local storage when user taps logout */
    
    func logout() {
        //var userDefaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.removeObject(forKey: "currentUser")
        defaults.removeObject(forKey: "UID")
        defaults.synchronize()
    }
}
