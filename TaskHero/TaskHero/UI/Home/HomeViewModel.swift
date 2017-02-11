
import UIKit



struct HomeViewModel {
    
    var store = UserDataStore.sharedInstance
    
    var user: User!
    
    var usernameText: String {
        return store.currentUser.username
    }
    
    var levelText: String {
        return store.currentUser.level
    }
    
    var numberOfRows: Int {
        if let currentUser = store.currentUser {
            if let tasks = currentUser.tasks {
                return tasks.count + 1
            }
        }
        return 0
    }

    var rowHeight = UITableViewAutomaticDimension
    
}
