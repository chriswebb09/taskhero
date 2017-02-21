//
//  ProfileViewController.swift
//  TaskHero
//

import UIKit
import Firebase

final class ProfileViewController: UITableViewController {
    
    var viewModel = ProfileViewModel()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupMethods()
        tableView.reloadOnMain()
    }
    
    /* On viewDidAppear ensure fresh user data from database is loaded and reloads TableView */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tableView.reloadOnMain()
    }
    
    func setupMethods() {
        registerCells()
        setupTableViewUI()
    }
    
    private func setupTableViewUI() {
        tableView.estimatedRowHeight = view.frame.height / 3
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        let rightBarImage: UIImage = SharedMethods.getAddTaskImage()
        let leftBarItem = SharedMethods.getLeftBarItem(selector: #selector(logoutButtonPressed), viewController: self)
        let rightBarItem = SharedMethods.getRightBarItem(image: rightBarImage, selector: #selector(addTaskButtonTapped), viewController: self)
        SharedMethods.setupNavItems(navigationItem: navigationItem, leftBarItem: leftBarItem, rightItem: rightBarItem)
    }
    
    private func registerCells() {
        tableView.register(ProfileDataCell.self, forCellReuseIdentifier: ProfileDataCell.cellIdentifier)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
    }
    
    // MARK: UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    /* Gives an automatic dimension to tableView based on given default value for rowheight*/
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return viewModel.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type: ProfileCellType = indexPath.row == 0 ? .header : .data
        switch type {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            setupHeader(headerCell: headerCell)
            return headerCell
        case .data:
            let dataCell = tableView.dequeueReusableCell(withIdentifier: type.identifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.configureCell()
            return dataCell
        }
    }
    
    func setupHeader(headerCell: ProfileHeaderCell) {
        headerCell.emailLabel.isHidden = true
        headerCell.configureCell(user: viewModel.user)
    }
    
    // MARK: - Selector Methods
    
    func logoutButtonPressed() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "hasLoggedIn")
        defaults.synchronize()
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
    }
}

extension ProfileViewController: ProfileHeaderCellDelegate {
    func profilePictureTapped(sender: UIGestureRecognizer) {
        print("tap")
    }
}
