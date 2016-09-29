//
//  HomeViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController, UISearchResultsUpdating {
    
    var parentNavigationController: UINavigationController?
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.white
        
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        // Do any additional setup after loading the view, typically from a nib.
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-gray")?.withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(addTaskButtonTapped))
        
        let barButton = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        barButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.font, size: 20)!], for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!], for: .normal)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.cellIdentifier, for: indexPath as IndexPath) as! ProfileHeaderCell
            cell.layoutSubviews()
            cell.usernameLabel.text = "filler text"
            cell.profilePicture.backgroundColor = UIColor.blue
            return cell
        } else {
            let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath as IndexPath) as! TaskCell
            taskCell.layoutSubviews()
            taskCell.taskLabel.text = "task filler"
            taskCell.taskDue.text =  "task due filler"
//            if store.currentUser.tasks[indexPath.row].completed == true {
//                taskCell.taskCompletedLabel.backgroundColor = UIColor.blue
//            }
            return taskCell
        }
    }
    

    
    
}

extension HomeViewController: ProfileHeaderCellDelegate {
    
    func logoutButtonPressed() {
        let loginVC = UINavigationController(rootViewController:LoginViewController())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func profilePictureTapped() {
        //        let profilePicVC = ProfilePictureViewController()
        //        navigationController?.pushViewController(profilePicVC, animated:false)
    }
    
    func addTaskButtonTapped() {
        let addTaskVC = AddTaskViewController()
        navigationController?.pushViewController(addTaskVC, animated:false)
    }
}

