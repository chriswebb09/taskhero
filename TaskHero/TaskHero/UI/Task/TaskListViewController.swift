import UIKit

final class TaskListViewController: BaseTableViewController {
    
    // MARK: Properties
    
    let store = UserDataStore.sharedInstance // userData store for application user state
    var tapped: Bool = false // tracks taps on taskcell completedView and button
    var taskViewModel: TaskCellViewModel! 
    let sharedTaskMethods = SharedTaskMethods()
    var listViewModel = TaskListViewModel()
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)
    
    var addTasksLabel: UILabel {
        didSet {
            print("Label hidden \(hidden)")
        }
    }
    
    var hidden: Bool {
        let hideText: Bool = self.store.tasks.count < 1 ? false : true
        return hideText
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init(_ coder: NSCoder? = nil) {
        self.addTasksLabel = UILabel()
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        listViewModel.initializeBackgroundUI(controller: self)
        listViewModel.configureAddTaskLabel(label: addTasksLabel)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        store.firebaseAPI.tasksRef.removeObserver(withHandle: store.firebaseAPI.refHandle)
    }
    
    // Does setupfor tableview/emptytable view and navbar 
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser(tableView: tableView)
       // tableView.reloadOnMain()
        addTasksLabel.isHidden = hidden
        DispatchQueue.main.async {
            self.listViewModel.emptyTableViewState(view: self.view, addTaskLabel: self.addTasksLabel)
            self.tableView.reloadOnMain()
        }
        super.viewWillAppear(false)
    }
}

// MARK: - UITableViewController Methods

extension TaskListViewController: TaskCellDelegate {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(listViewModel.numberOfRows)
        print(self.store.tasks)
        return self.store.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
        _ = tableView.rowHeight - 5
        taskViewModel = TaskCellViewModel(store.tasks[indexPath.row])
        taskCell.delegate = self
        let tap = UIGestureRecognizer(target: self, action: #selector(toggleForEditState(_:)))
        taskCell.taskCompletedView.addGestureRecognizer(tap)
        taskCell.configureCell(taskVM: taskViewModel)
        return taskCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard self.store.tasks.count > 0 else { return }
            tableView.beginUpdates()
            backgroundQueue.async {
                self.sharedTaskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView, type: .taskList)
                self.fetchUser(tableView: tableView)
                DispatchQueue.main.async {
                    self.addTasksLabel.isHidden = self.hidden
                }
                self.tableView.reloadOnMain()
            }
            tableView.endUpdates()
        }
    }
    
    // MARK: - Public Methods
    
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Tasks To Do")
        default:
            print("Tasks Completed")
        }
        tableView.reloadOnMain()
    }
    
    // MARK: - Button methods
    
    override func logoutButtonPressed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //DataPeristence.shared.logout()
        //DataPeristence.shared.logout()
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:LoginViewController())
    }
    
    // MARK: - Task Actions
    
    override func addTaskButtonTapped() {
        self.navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
    
    // MARK: - Cell Button Toggle Methods
    
    func toggleForButtonState(_ sender:UIButton) {
        let superview = sender.superview
        guard let cell = superview?.superview as? TaskCell else { return }
        let indexPath = tableView.indexPath(for: cell)
        if let index = indexPath {
            sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: index, type: .taskList)
        }
    }
    
    // Kicks off cycling between taskcell editing states
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        guard let tapIndex = tableView.indexPathForRow(at: tapLocation) else { return }
        sharedTaskMethods.tapEdit(viewController: self, tableView: tableView, atIndex: tapIndex, type: .taskList)
    }
}
