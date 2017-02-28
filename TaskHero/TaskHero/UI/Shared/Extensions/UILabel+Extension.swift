//
//  UILabel+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit 


extension UILabel {
//    var settingLabel: UILabel = {
//        let textView = UILabel()
//        textView.textColor = .white
//        textView.textAlignment = .center
//        textView.layer.masksToBounds = true
//        textView.font = Constants.Font.fontNormal
//        return textView
//    }()
    
    class func centerLabel(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = font
        return label
    }
}
