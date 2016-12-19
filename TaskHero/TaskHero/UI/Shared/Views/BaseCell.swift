//
//  BaseCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol BaseCellModel {
    func configure(data: NSObject)
}

protocol BaseCellViewModel {
    var cellIdentifier: String! { get set }
}

class BaseCell: UITableViewCell, BaseCellModel, BaseCellViewModel {
    var cellIdentifier: String! = "cellID"
    func configure(data: NSObject) {
        
    }
}
