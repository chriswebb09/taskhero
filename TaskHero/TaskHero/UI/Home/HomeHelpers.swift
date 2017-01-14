//
//  HomeHelpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 1/13/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Toggable {
    func toggleState(state:Bool) -> Bool
}

extension Toggable {
    func toggleState(state:Bool) -> Bool {
        return !state
    }
}


