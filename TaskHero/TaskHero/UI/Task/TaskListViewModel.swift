import UIKit

struct TaskListViewModel {
    
    let store = UserDataStore.sharedInstance
    
    var sharedTaskMethods = SharedTaskMethods()
    
    var numberOfRows: Int {
        var rows = 0
        if let user = self.store.currentUser {
            let taskList = self.store.currentUser.tasks
            if let tasks = taskList?.count {
                rows = tasks
            }
           
        }
        return rows
    }
    
    var showTaskLabel: Bool {
        return store.tasks.count > 0 ? false : true
    }
    
    var taskLabelText: String {
        let labelText: String = showTaskLabel == true ? "No tasks have been added yet." : ""
        return labelText
    }
    
    var taskLabelColor: UIColor = {
        return .lightGray
    }()
    
    let tableBackGroundColor: UIColor = {
        return Constants.Color.tableViewBackgroundColor.setColor
    }()
    
    var tasks: [Task] {
        var taskList = [Task]()
        if let user = self.store.currentUser {
            taskList = self.store.currentUser.tasks!
            
        }
        return taskList
    }
    
    func configureAddTaskLabel(label: UILabel) {
        label.font = Constants.Font.fontNormal
        label.textColor = .gray
        label.textAlignment = .center
    }
    
    func emptyTableViewState(view: UIView, addTaskLabel:UILabel) {
        if (store.tasks.count <= 1) && (!addTaskLabel.isHidden) {
            view.addSubview(addTaskLabel)
            addTaskLabel.center = view.center
            addTaskLabel.text = taskLabelText
            addTaskLabel.translatesAutoresizingMaskIntoConstraints = false
            addTaskLabel.snp.makeConstraints { make in
                make.height.equalTo(view.snp.height).multipliedBy(Constants.Dimension.mainHeight)
                make.width.equalTo(view.snp.width).multipliedBy(Constants.Dimension.width)
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
            }
            addTaskLabel.isHidden = false
        }
        let hideText: Bool = self.store.tasks.count < 1 ? false : true
        addTaskLabel.isHidden = hideText
    }
    
    func initializeBackgroundUI(controller: TaskListViewController) {
        controller.register(tableView: controller.tableView, cells: [TaskCell.self])
        controller.edgesForExtendedLayout = []
        controller.view.backgroundColor = Constants.Color.tableViewBackgroundColor.setColor
        UITableViewController.setupTableView(tableView: controller.tableView, view: controller.view)
        
        BaseViewController.barSetup(controller: controller)
        controller.addTasksLabel = UILabel()
        controller.addTasksLabel.isHidden = controller.hidden
    }
}
