//
//  HomeHelpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/8/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


enum HomeCellType {
    case task, header
}

protocol Toggable {
    func toggleState(state:Bool) -> Bool
}

extension Toggable {
    func toggleState(state:Bool) -> Bool {
        return !state
    }
}
