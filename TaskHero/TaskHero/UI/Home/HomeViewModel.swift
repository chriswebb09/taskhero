
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
        // var rows = 0
        if let currentUser = store.currentUser {
            if let tasks = currentUser.tasks {
                return tasks.count + 1
            }
        }
        return 0
        //guard let tasks = store.currentUser.tasks else { return 1 }
        //return tasks.count + 1
    }
    
//    var tasks: [Task] {
//        guard let tasks = store.currentUser.tasks else { return [] }
//        return tasks
//    }
    
    var rowHeight = UITableViewAutomaticDimension
    
}
