import UIKit

struct TaskListViewModel {
    
    let store = UserDataStore.sharedInstance
    
    var sharedTaskMethods = SharedTaskMethods()
    
    var numberOfRows: Int {
        if let user = store.currentUser, let tasks = user.tasks {
            return tasks.count
        }
        return 0
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
        if let tasks = store.currentUser.tasks {
            return tasks
        }
        return [Task]()
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
        controller.tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        controller.edgesForExtendedLayout = []
        controller.view.backgroundColor = Constants.Color.tableViewBackgroundColor.setColor
        sharedTaskMethods.setupTableView(tableView: controller.tableView, view: controller.view)
        barSetup(controller: controller)
        controller.addTasksLabel = UILabel()
        controller.addTasksLabel.isHidden = controller.hidden
    }
    
    func barSetup(controller: TaskListViewController) {
        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
        let leftBarItem = SharedMethods.getLeftBarItem(selector: #selector(controller.logoutButtonPressed), viewController: controller)
        let rightBarItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(controller.addTaskButtonTapped), viewController: controller)
        SharedMethods.setupNavItems(navigationItem: controller.navigationItem, leftBarItem: leftBarItem, rightItem: rightBarItem)
    }
    
}
