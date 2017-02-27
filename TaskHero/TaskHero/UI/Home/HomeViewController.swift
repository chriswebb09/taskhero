//
//  HomeViewController.swift
//  TaskHero
//

import UIKit
import Firebase

/* HomeViewController is the first tab in the tabbar. It is a subclass of UITableViewController. At index.row 0 the cell type returned is ProfileHeaderCell after that all other cells are of type TaskCell */

final class HomeViewController: BaseProfileViewController, UINavigationControllerDelegate {
    
    var homeViewModel: HomeViewModel
    var taskMethods = SharedTaskMethods()
    
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.viewSetup(controller: self)
        BaseViewController.barSetup(controller: self)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init(_ coder: NSCoder? = nil) {
        self.homeViewModel = HomeViewModel()
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewModel.onViewWillAppear(controller: self)
        super.viewWillAppear(false)
    }
    
    /*
     Removes reference to database (necessary to prevent duplicate taskCells from being create everytime viewWillAppear is called)
     - functionality implemented in helper class
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        homeViewModel.removeRefHandle()
    }
}

// MARK: - UITableViewController Methods

extension HomeViewController {
    
    /* Get number of rows from viewModel - number of row is equal to number of tasks in currentUser plus one */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows
    }
    
    /* Get rowheight from viewModel - rowheight is UITableViewAutomaticDimension */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeViewModel.rowHeight
    }
    
    /* first row returns profile headerCell all other rows are type taskCell -> cells configured within this controller using setupCell methods */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type: HomeCellType = indexPath.row > 0 ? .task : .header
        return homeViewModel.returnCell(tableViewController: self, type: type, for: indexPath)
    }
}

// MARK: - Delete Tasks

extension HomeViewController {
    
    /* Cannot edit cell at tableview index row 0 */
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    /* Logic for deleting tasks from database when user deletes tableview cell */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.homeViewModel.delete(controller: self, at: indexPath)
        }
    }
}

// MARK:  TaskCell Delegate Methods

extension HomeViewController: TaskCellDelegate {
    
    func toggleForButtonState(_ sender:UIButton) {
        homeViewModel.buttonTap(sender: sender, controller: self)
    }
    
    /* Kicks off cycling between taskcell editing states */
    
    func toggleForEditState(_ sender:UIGestureRecognizer) {
        homeViewModel.editTap(sender: sender, controller: self)
    }
}

// MARK: - ProfileHeaderCell Delegate

extension HomeViewController: ProfileHeaderCellDelegate {
    
    internal func hidePopoverView() {
        photoPopover.hidePopView(viewController: self)
    }
    
    internal func profilePictureTapped(sender: UIGestureRecognizer) {
        BaseTableViewController.profilePictureTapped(controller: self)
    }
}

// Mark: - UIImagePicker Delegate

extension HomeViewController: UIImagePickerControllerDelegate {
    
    func selectImage(picker: UIImagePickerController, viewController: UIViewController) {
        BaseTableViewController.imageSelection(controller: self)
    }
    
    internal override func tapPickPhoto(_ sender: UIButton) {
        UITableViewController.photoTapped(controller: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        homeViewModel.profilePic = BaseViewController.photoForPicker(controller: self, info: info)
        UserDataStore.sharedInstance.currentUser.userProfilePic = BaseViewController.photoForPicker(controller: self, info: info)
    }
}
