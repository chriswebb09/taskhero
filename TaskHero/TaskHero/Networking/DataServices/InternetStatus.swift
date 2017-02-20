//
//  InternetStatus.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class InternetStatus {
    var hasInternet: Bool = false
    
    static let shared = InternetStatus()
    private init() {}
}

