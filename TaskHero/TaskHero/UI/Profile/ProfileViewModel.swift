//
//  ProfileViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfileViewModel: BaseModelProtocol {
    
    var profilePic: UIImage?
    
    let store = UserDataStore.sharedInstance
    
    var user: User {
        return store.currentUser
    }
    
    var numberOfRows: Int {
        return 2
    }
    
    var rowHeight: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setupHeader(headerCell: ProfileHeaderCell, controller: ProfileViewController) {
        let tap = UIGestureRecognizer(target:self, action: #selector(controller.profilePictureTapped(sender:)))
        headerCell.profilePicture.addGestureRecognizer(tap)
        headerCell.emailLabel.isHidden = true
        headerCell.configureCell(user: user)
        headerCell.delegate = controller
    }
    
    func setupTableViewUI(controller: ProfileViewController) {
        controller.tableView.estimatedRowHeight = controller.view.frame.height / 3
        controller.tableView.tableFooterView = UIView(frame: .zero)
        BaseViewController.barSetup(controller: controller)
        controller.tableView.separatorStyle = .none
    }
}


enum ProfileCellType {
    case header, data
    
    var identifier: String {
        switch self {
        case .header:
            return ProfileHeaderCell.cellIdentifier
        case .data:
            return ProfileDataCell.cellIdentifier
        }
    }
}
