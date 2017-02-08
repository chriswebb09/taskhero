//
//  HomeViewControllerDataSource.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/2/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum HomeCellType {
    case task, header
}

final class HomeViewControllerDataSource {
    
    /* Temporary abstraction of HomeViewController behavior. 
       Not finalized will be organized into datasource and flowcontroller */
    /* Number of rows in HomeViewController, if no tasks it returns 1 for ProfileHeaderCell */
    
    let store = UserDataStore.sharedInstance
    var tableIndexPath: IndexPath!
    //var autoHeight: UIViewAutoresizing?

    /* Methods for configure UIElements + registers cell types for tableView sets estimatedRowHeight and registers cell types */
    
    func setupView(tableView: UITableView, view: UIView) {
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.cellIdentifier)
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.setupTableView()
        tableView.estimatedRowHeight = view.frame.height / 4
        view.backgroundColor = Constants.Color.tableViewBackgroundColor
    }
    
    /* Method choosing profilePicture for Header cell */
    
    func selectImage(picker:UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
    
    /* Deletes task at indexPath.row - 1 (subtraction because TaskCells are below the profileHeader cell) */
}

protocol Toggable {
    func toggleState(state:Bool) -> Bool
}

extension Toggable {
    func toggleState(state:Bool) -> Bool {
        return !state
    }
}




