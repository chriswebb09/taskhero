//
//  SetupNav.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupNav() {
        self.navigationBar.isHidden = false
        self.navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.NavBar.bottomHeight)
    }
}
