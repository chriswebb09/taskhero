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

extension ProfileSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupTableViewDelegates()
        setupSubviews()
        profileSettingsView.layoutSubviews()
        dataSource.setupViews(profileSettingsView: profileSettingsView, tableView: tableView, view: view)
        tableView.setupTableView(view: view)
        tableView.separatorColor = .black
    }
    
    func setupTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSubviews() {
        view.addSubview(profileSettingsView)
        view.addSubview(tableView)
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.cellIdentifier)
    }
}

extension ProfileSettingsViewController: UITextFieldDelegate, ProfileSettingsCellDelegate {
    
    // MARK: UITableViewController Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource.options)
        return dataSource.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileSettingsCell
        cell.configureCell(setting: dataSource.options[indexPath.row])
        cell.delegate = self
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
            if tapped == true {
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
            } else {
                tapped = true
                tapCell.profileSettingLabel.isHidden = true
                tapCell.profileSettingField.isHidden = false
            }
        }
    }
    
    fileprivate func separateNames(name:String) -> [String] {
        let nameArray = name.components(separatedBy: " ")
        return nameArray
    }
    
    func editButtonTapped() {
        tapped = true
    }
}



