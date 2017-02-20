import UIKit

final class SettingsViewController: UITableViewController {
    
    // MARK: - Properties
    
    let applicationSettings = ["Notifications"]
    let userSettings = ["Edit Profile", "Friends"]
    let segmentControl = UISegmentedControl(items: ["User Settings", "Application Settings"])
    let label = UILabel()
    var settings = [String]()
    let alertPop = AlertPopover()
    let notifyPop = NotificationPopover()
    var settingsViewModel:SettingsCellViewModel!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = userSettings
        edgesForExtendedLayout = []
        view.backgroundColor = .backgroundColor()
        tableView.separatorColor = .blue
        navigationController?.navigationBar.setBottomBorderColor(color: .lightGray,
                                                                 height: Constants.Border.borderWidth)
        setupTableView()
    }
    
    func setupTableView() {
        let header = UIView(frame:CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: 50))
        header.addSubview(segmentControl)
        tableView.tableHeaderView = header
        header.backgroundColor = .white
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
        tableView.setupTableView(view:self.view)
        setupSegment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        hide()
    }
    
    // MARK: UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier, for: indexPath as IndexPath) as! SettingsCell
        settingsViewModel = SettingsCellViewModel(settings[indexPath.row])
        settingsCell.configureCell(setting: settingsViewModel)
        settingsCell.contentView.clipsToBounds = true
        return settingsCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pushedVC: UIViewController = settings[indexPath.row] == "Edit Profile" ? ProfileSettingsViewController() : FriendsSettingsViewController()
        if settings[indexPath.row] == "Notifications" {
            notificationPopup()
            notifyPop.notifyPopView.doneButton.addTarget(self, action: #selector(dismissNotificationButton), for: .touchUpInside)
        } else {
            navigationController?.pushViewController(pushedVC, animated: true)
        }
    }
    
    // MARK: Public Methods
    
    fileprivate func alertPopInitialOpacity() {
        alertPop.popView.isHidden = false
        alertPop.containerView.isHidden = false
        alertPop.containerView.layer.opacity = 0
        alertPop.popView.layer.opacity = 0
    }
    
    fileprivate func launchPopupView() {
        alertPopInitialOpacity()
        alertPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.alertPop.popView.layer.opacity = 1
            self.alertPop.containerView.layer.opacity = 0.1
        }
        self.alertPop.alertPopView.resultLabel.text = "Try Again Later."
        self.alertPop.alertPopView.doneButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        self.alertPop.alertPopView.cancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    // Displays popover when notifications cell is selected
    
    private func notificationPopInitialOpacity() {
        notifyPop.popView.isHidden = false
        notifyPop.containerView.isHidden = false
        notifyPop.containerView.layer.opacity = 0
        notifyPop.popView.layer.opacity = 0
    }
    
    func notificationPopup() {
        notificationPopInitialOpacity()
        notifyPop.showPopView(viewController: self)
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.notifyPop.popView.layer.opacity = 1
            self.notifyPop.containerView.layer.opacity = 0.1
            self.notifyPop.layoutIfNeeded()
        }
    }
    
    // MARK: - Setup buttons
    // Hides notification popover
    
    func dismissNotificationButton() {
        notifyPop.popView.isHidden = true
        notifyPop.containerView.isHidden = true
        notifyPop.hidePopView(viewController: self)
    }
    
    func dismissButton() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
    
    func hide() {
        alertPop.popView.isHidden = true
        alertPop.containerView.isHidden = true
        alertPop.hidePopView(viewController: self)
    }
}

extension SettingsViewController {
    
    // MARK: - Switch between segments
    
    func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings = userSettings
            segmentControl.subviews[0].backgroundColor = .white
            
        default:
            settings = applicationSettings
            segmentControl.subviews[1].backgroundColor = .white
        }
        tableView.reloadData()
    }
    
    // MARK: - Segment Control UI
    
    func setupSegment() {
        let multipleAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.white]
        let multipleUnselectedAttributes: [String : Any] = [NSForegroundColorAttributeName: UIColor.black]
        
        segmentControl.tintColor = .black
        segmentControl.setTitleTextAttributes(multipleAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(multipleUnselectedAttributes, for:.normal)
        segmentControl.layer.cornerRadius = Constants.Settings.Segment.segmentBorderRadius
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
            if let header = self.tableView.tableHeaderView {
                make.top.equalTo(header.snp.top)
                make.height.equalTo(header.snp.height)
            }
        }
        segmentControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
}

protocol Hiddable {
    func hide(view:UIView)
}

extension Hiddable {
    func hide(view:UIView, viewController:UIViewController) {
        print("Not implemented")
    }
}
