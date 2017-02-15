import UIKit
import Firebase

final class ProfileSettingsViewControllerDataSource {
    
    // MARK: - Properties
    
    let store = UserDataStore.sharedInstance
    
    func setupViews(profileSettingsView: ProfileSettingsView, tableView: UITableView, view:UIView) {
        profileSettingsView.translatesAutoresizingMaskIntoConstraints = false
        profileSettingsView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).multipliedBy(Constants.Settings.Profile.profileViewHeightAnchor)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).multipliedBy(Constants.Settings.tableViewHeight)
        }
    }
    
    func updateUserName(cell: ProfileSettingsCell, name:[String]) {
        var name = cell.profileSettingField.text?.components(separatedBy: " ")
        let updatedUser = User()
        updatedUser.username = store.currentUser.username
        updatedUser.email = store.currentUser.email
        updatedUser.profilePicture = "None"
        updatedUser.firstName = name?[0]
        updatedUser.lastName = name?[1]
        updatedUser.joinDate = store.currentUser.joinDate
        updatedUser.numberOfTasksCompleted = store.currentUser.numberOfTasksCompleted
        updatedUser.experiencePoints = store.currentUser.experiencePoints
        updatedUser.tasks = store.currentUser.tasks
        updateUserProfile(userID: store.currentUser.uid, user: updatedUser)
    }
    
    func updateUserProfile(userID: String, user:User) {
        store.firebaseAPI.updateUserProfile(userID: userID, user: user, tasks:store.tasks)
        store.tasks.forEach { task in
            self.store.firebaseAPI.updateTask(ref: task.taskID, taskID: task.taskID, task: task)
        }
    }
    
    func setupUser(user: User) {
        store.firebaseAPI.registerUser(user: user)
        store.firebaseAPI.setupRefs()
        store.currentUser = user
    }
    
}
