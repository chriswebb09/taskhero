//
//  ProfileSettingsViewController+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/6/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension ProfileSettingsViewController {
    
    //=======================================
    // MARK: - Setup tableView
    //=======================================
    
    fileprivate func separateNames(name:String) -> [String] {
        let nameArray = name.components(separatedBy: " ")
        return nameArray
    }
    
    func editButtonTapped() {
        tapped = true
    }
}
