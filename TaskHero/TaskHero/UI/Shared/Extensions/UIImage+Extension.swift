//
//  UIImage+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum Quality: CGFloat {
        case worst  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case best  = 1
    }
    var png: Data? { return UIImagePNGRepresentation(self) }
    
    func jpeg(_ quality: Quality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}


extension UIImage {
    class func getAddTaskImage() -> UIImage? {
        if let image = UIImage(named: "add-white-2") {
            return image
        }
        return nil
    }
}
