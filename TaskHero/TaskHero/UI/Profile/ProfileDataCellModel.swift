//
//  ProfileDataCellModel.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/21/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol ProfileDataCellViewViewModel {

    var level: String { get }
    var experience: String { get }
    var tasksCompleted: String { get }
}
