//
//  HomeHelpers.swift
//  TaskHero
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
