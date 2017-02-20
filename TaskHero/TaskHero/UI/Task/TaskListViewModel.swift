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
}
