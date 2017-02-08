//
//  UINavigationBar+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    // Setup gray underline UINavigationBar
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}



extension UINavigationController {
    
    func setupNav() {
        navigationBar.isHidden = false
        navigationBar.setBottomBorderColor(color: UIColor.lightGray, height: Constants.Border.borderWidth)
    }
}
