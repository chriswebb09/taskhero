//
//  HomeViewController.swift
//  TaskHero
//

import UIKit
import Firebase

/* HomeViewController is the first tab in the tabbar. It is a subclass of UITableViewController. At index.row 0 the cell type returned is ProfileHeaderCell after that all other cells are of type TaskCell */

final class HomeViewController: UITableViewController, UINavigationControllerDelegate {
    
    var homeViewModel: HomeViewModel
    var taskMethods = SharedTaskMethods()
    
    let backgroundQueue = DispatchQueue(label: "com.taskhero.queue", qos: .background, target: nil)
    
    let photoPopover = PhotoPickerPopover()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.viewSetup(viewController: self)
        homeViewModel.barSetup(controller: self)
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
            tableView.beginUpdates()
            backgroundQueue.async {
                self.taskMethods.deleteTask(indexPath: indexPath, tableView: self.tableView, type: .home)
                self.taskMethods.fetchUser(tableView: self.tableView)
            }
            tableView.endUpdates()
        }
    }
}

// MARK: Selector Methods

extension HomeViewController {
    
    func logoutButtonPressed() {
        homeViewModel.setupUserDefaults()
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                homeViewModel.setupAppScreen()
            } catch {
                print("Error")
                homeViewModel.setupAppScreen()
            }
        }
    }
    
    func addTaskButtonTapped() {
        navigationController?.pushViewController(AddTaskViewController(), animated:false)
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
        photoPopover.showPopView(viewController: self)
        photoPopover.photoPopView.button.addTarget(self, action: #selector(tapPickPhoto(_:)), for: .touchUpInside)
    }
}

// Mark: - UIImagePicker Delegate

extension HomeViewController: UIImagePickerControllerDelegate {
    
    func selectImage(picker: UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    internal func tapPickPhoto(_ sender:UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        photoPopover.hideView(viewController: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            homeViewModel.profilePic = image
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
