//
//  ProfileViewController.swift
//  TaskHero
//

import UIKit
import Firebase

final class ProfileViewController: UITableViewController {
    
    let store = UserDataStore.sharedInstance
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        registerCells()
        setupTableViewUI()
        setupNavItems()
        tableView.reloadData()
    }
    
    /* On viewDidAppear ensure fresh user data from database is loaded and reloads TableView */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tableView.reloadData()
    }
}

extension ProfileViewController {
    
    func setupTableViewUI() {
        tableView.estimatedRowHeight = view.frame.height / 3
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func registerCells() {
        tableView.register(ProfileDataCell.self, forCellReuseIdentifier: ProfileDataCell.cellIdentifier)
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
    }
    
    // MARK: UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /* Gives an automatic dimension to tableView based on given default value for rowheight*/
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            headerCell.emailLabel.isHidden = true
            headerCell.configureCell(user: self.store.currentUser)
            return headerCell
        } else {
            let dataCell = tableView.dequeueReusableCell(withIdentifier: ProfileDataCell.cellIdentifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.configureCell()
            return dataCell
        }
    }
    
    // MARK: - Delegate Methods
    
    func setupNavItems() {
        navigationController?.navigationBar.setBottomBorderColor(color: .lightGray, height: Constants.Border.borderWidth)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-white-2")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontMedium], for: .normal)
    }
    
    // MARK: - Button methods
    // On logout button press sets RootViewController to LoginViewController on main thread
    
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
