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
        setupNavItems()
    }
    
    private func setupTableViewUI() {
        tableView.estimatedRowHeight = view.frame.height / 3
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
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
        var type: ProfileCellType = indexPath.row == 0 ? .header : .data
        switch type {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell(user: viewModel.user)
            return headerCell
        case .data:
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.configureCell()
            return dataCell
        }
    }
    
    func setupNavItems() {
        let rightBarImage: UIImage? = UIImage(named: "add-white-2")
        let leftBarAttributes: [String: Any] = [NSForegroundColorAttributeName: UIColor.white,
                                                NSFontAttributeName: Constants.Font.fontMedium]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarImage?.withRenderingMode(.alwaysOriginal),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addTaskButtonTapped))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(leftBarAttributes, for: .normal)
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
