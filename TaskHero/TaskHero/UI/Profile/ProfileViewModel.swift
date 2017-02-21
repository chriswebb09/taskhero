//
//  ProfileViewModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct ProfileViewModel {
    
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
