//
//  HomeViewModel.swift
//  TaskHero
//

import UIKit

enum HomeCellType {
    case task, header
    var identifier: String {
        switch self {
        case .header:
            return ProfileHeaderCell.cellIdentifier
        case .task:
            return TaskCell.cellIdentifier
        }
    }
}

class HomeViewModel: BaseProfileViewModel {
    
    var store = UserDataStore.sharedInstance
    
    fileprivate let concurrentQueue = DispatchQueue(label: "com.taskHero.concurrentQueue", attributes: .concurrent)
    
    var taskMethods = SharedTaskMethods()
    
    var user: User? {
        return self.store.currentUser
    }
    
    var usernameText: String {
        return store.currentUser.username
    }
    
    var levelText: String {
        return store.currentUser.level
    }
    
    var numberOfRows: Int {
        let rows: Int = self.store.tasks.count <= 0 ? 1 : self.store.tasks.count + 1
        return rows
    }
    
    var taskList: [Task] {
        return self.store.tasks
    }
    
    var rowHeight = UITableViewAutomaticDimension
    
    func removeRefHandle() {
        if store.firebaseAPI.refHandle != nil {
            self.store.firebaseAPI.tasksRef.removeObserver(withHandle: self.store.firebaseAPI.refHandle)
        }
    }
    
    func getViewModelForTask(taskIndex: Int) -> TaskCellViewModel {
        return TaskCellViewModel(taskList[taskIndex - 1])
    }
    
    func objectAtIndexPath(indexPath: IndexPath) -> Task? {
        return taskList.indices.contains(indexPath.row) ? taskList[indexPath.row] : nil
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return taskList.count
    }
    
    func viewSetup(viewController: HomeViewController) {
        AppFunctions.register(tableView: viewController.tableView, cells: [TaskCell.self, ProfileHeaderCell.self])
        taskMethods.setupTableView(tableView: viewController.tableView, view: viewController.view)
        
        viewController.view.backgroundColor = Constants.Color.tableViewBackgroundColor.setColor
        viewController.picker.delegate = viewController
        viewController.edgesForExtendedLayout = []
    }
    
    func returnCell(tableViewController: HomeViewController, type: HomeCellType, for indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
            
        case .task:
            let taskCell = tableViewController.tableView.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! TaskCell
            setupTaskCell(taskCell: taskCell, taskIndex: indexPath.row)
            taskCell.delegate = tableViewController
            addInteractionToCell(cell: taskCell, viewController: tableViewController)
            return taskCell
            
        case .header:
            let headerCell = tableViewController.tableView.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! ProfileHeaderCell
            setupHeaderCell(headerCell: headerCell, indexPath: indexPath)
            headerCell.delegate = tableViewController
            let tap = UIGestureRecognizer(target:self, action: #selector(tableViewController.profilePictureTapped(sender:)))
            headerCell.profilePicture.addGestureRecognizer(tap)
            if profilePic != nil { headerCell.profilePicture.image = profilePic! }
            return headerCell
        }
    }
    
    func addInteractionToCell(cell: TaskCell, viewController: HomeViewController) {
        let tap = UIGestureRecognizer(target:self, action: #selector(viewController.toggleForEditState(_:)))
        cell.taskCompletedView.addGestureRecognizer(tap)
    }
    
    func setupUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.synchronize()
    }
    
    func setupHeaderCell(headerCell: ProfileHeaderCell, indexPath: IndexPath) {
        headerCell.emailLabel.isHidden = true
        if let user = user { headerCell.configureCell(user: user) }
    }
    
    func setupTaskCell(taskCell:TaskCell, taskIndex: Int) {
        let taskViewModel = getViewModelForTask(taskIndex: taskIndex)
        taskCell.configureCell(taskVM: taskViewModel)
        taskCell.tag = taskIndex
    }
    
    func setupAppScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController:AppScreenViewController())
    }
    
    func onViewWillAppear(controller: HomeViewController) {
        AppFunctions.fetchUser(tableView: controller.tableView)
        controller.tableView.reloadOnMain()
    }
    
    func editTap(sender: UIGestureRecognizer, controller: HomeViewController) {
        let tapLocation = sender.location(in: controller.tableView)
        let tapIndex = controller.tableView.indexPathForRow(at: tapLocation)
        if let index = tapIndex {
            taskMethods.tapEdit(viewController: controller, tableView: controller.tableView, atIndex:index, type: .home)
        }
    }
    
    func buttonTap(sender: UIButton, controller: HomeViewController) {
        let superview = sender.superview
        let cell = superview?.superview as! TaskCell
        let indexPath = controller.tableView.indexPath(for: cell)
        if let index = indexPath {
            taskMethods.tapEdit(viewController: controller, tableView: controller.tableView, atIndex: index, type: .home)
        }
    }
    
    func delete(controller: HomeViewController, at indexPath: IndexPath) {
        controller.tableView.beginUpdates()
        controller.backgroundQueue.async {
            self.taskMethods.deleteTask(indexPath: indexPath, tableView: controller.tableView, type: .home)
            AppFunctions.fetchUser(tableView: controller.tableView)
        }
        controller.tableView.endUpdates()
    }
}

