//
//  ProfileViewController.swift
//  TaskHero
//

import UIKit
import Firebase

final class ProfileViewController: BaseProfileViewController {
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMethods()
    }
    
    // On viewDidAppear ensure fresh user data from database is loaded and reloads TableView 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tableView.reloadOnMain()
    }
    
    func setupMethods() {
        register(tableView: tableView, cells: [ProfileHeaderCell.self, ProfileDataCell.self])
        viewModel.setupTableViewUI(controller: self)
        edgesForExtendedLayout = []
        tableView.reloadOnMain()
    }
    
    // MARK: UITableViewController Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    // Gives an automatic dimension to tableView based on given default value for rowheight
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return viewModel.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type: ProfileCellType = indexPath.row == 0 ? .header : .data
        switch type {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            viewModel.setupHeader(headerCell: headerCell, controller: self)
            if viewModel.profilePic != nil {
                headerCell.profilePicture.image = viewModel.profilePic!
            }
            return headerCell
        case .data:
            let dataCell = tableView.dequeueReusableCell(withIdentifier: type.identifier, for:indexPath as IndexPath) as! ProfileDataCell
            dataCell.configureCell()
            return dataCell
        }
    }
}
// MARK: - ProfileHeaderCell Delegate

extension ProfileViewController: ProfileHeaderCellDelegate {
    
    internal func hidePopoverView() {
        photoPopover.hidePopView(viewController: self)
    }
    
    internal func profilePictureTapped(sender: UIGestureRecognizer) {
        BaseTableViewController.profilePictureTapped(controller: self)
    }
}

// Mark: - UIImagePicker Delegate

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func selectImage(picker: UIImagePickerController, viewController: UIViewController) {
        BaseTableViewController.imageSelection(controller: self)
    }
    
    internal override func tapPickPhoto(_ sender: UIButton) {
        UITableViewController.photoTapped(controller: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        viewModel.profilePic = BaseViewController.photoForPicker(controller: self, info: info)
        UserDataStore.sharedInstance.currentUser.userProfilePic = BaseViewController.photoForPicker(controller: self, info: info)
    }
}

