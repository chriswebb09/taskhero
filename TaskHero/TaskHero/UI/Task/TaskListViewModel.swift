import UIKit

struct TaskListViewModel {
    
    let store = UserDataStore.sharedInstance
    
    var numberOfRows: Int {
        guard let tasks = store.currentUser.tasks else { return 0 }
        return tasks.count
    }
    
    var showTaskLabel: Bool {
        let condition: Bool = store.tasks.count > 0 ? false : true
        return condition
    }
    
    var taskLabelText: String {
        let labelText: String = showTaskLabel == true ? "No tasks have been added yet." : ""
        return labelText
    }
    
    var taskLabelColor: UIColor = {
        return .lightGray
    }()
    
    let tableBackGroundColor: UIColor = {
        return Constants.Color.tableViewBackgroundColor
    }()
}
