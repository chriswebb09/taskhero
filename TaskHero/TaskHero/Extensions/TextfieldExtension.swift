//
//  UITextfield+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/21/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TextFieldExtension: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
  
}
