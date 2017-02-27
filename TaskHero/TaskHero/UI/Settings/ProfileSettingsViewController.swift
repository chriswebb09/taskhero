import UIKit

final class ProfileSettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    let profileSettingsView = ProfileSettingsView()
    var tapped: Bool = false
    var indexTap: IndexPath?
    let tableView = UITableView()
    let dataSource = ProfileSettingsViewControllerDataSource()
    var username: String?
    var email: String?
}

extension ProfileSettingsViewController: UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupTableViewDelegates()
        setupSubviews()
    }
}

extension ProfileSettingsViewController: UITableViewDataSource {
    
    func setupTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(profileSettingsView)
        profileSettingsView.layoutSubviews()
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.cellIdentifier)
        dataSource.setupViews(profileSettingsView: profileSettingsView, tableView: tableView, view: view)
        tableView.setupTableView(view: view)
        tableView.separatorColor = .black
    }
}

extension ProfileSettingsViewController: UITextFieldDelegate, ProfileSettingsCellDelegate {
    
    // MARK: UITableViewController Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileSettingsCell
        cell.configureCell(setting: dataSource.options[indexPath.row], controller: self)
        cell.button.index = indexPath
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action:#selector(connected(sender:)), for: .touchUpInside)
        return cell
    }
    
    dynamic fileprivate func connected(sender: TagButton){
        indexTap = sender.index
        tapEdit()
    }
    
    fileprivate func tapEdit() {
        if let index = indexTap {
            let tapCell = tableView.cellForRow(at: index) as! ProfileSettingsCell
            if tapped {
                cellTapped(tapCell: tapCell, index: index)
            } else {
                cellNotTapped(tapCell: tapCell)
            }
        }
    }
    
    func cellTapped(tapCell: ProfileSettingsCell, index: IndexPath) {
        tapped = false
        if let cellText = tapCell.profileSettingField.text {
            if cellText.characters.count > 0 {
                guard let name = tapCell.profileSettingField.text?.components(separatedBy: " ") else { return }
                if index.row == 1 {
                    dataSource.updateUserName(cell: tapCell, name: name)
                } else if index.row == 3 {
                    dataSource.updateUserName(cell: tapCell, name: name)
                }
                tapCell.profileSettingLabel.text = tapCell.profileSettingField.text
            } else {
                tapCell.profileSettingLabel.text = dataSource.options[index.row]
            }
            tapCell.profileSettingField.isHidden = true
            tapCell.profileSettingLabel.isHidden = false
        }
    }
    
    func cellNotTapped(tapCell: ProfileSettingsCell) {
        tapped = true
        tapCell.profileSettingLabel.isHidden = true
        tapCell.profileSettingField.isHidden = false
    }
    
    fileprivate func separateNames(name:String) -> [String] {
        let nameArray = name.components(separatedBy: " ")
        return nameArray
    }
    
    func editButtonTapped() {
        tapped = true
    }
}



