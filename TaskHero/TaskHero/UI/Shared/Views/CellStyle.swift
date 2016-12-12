//
//  CellStyle.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/12/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct CellStyle {
    
    let labelColor: UIColor
    let labelFont: UIFont
    let detailColor: UIColor
    let detailFont: UIFont
    let accessory: UIImage
    
    init(labelColor: UIColor = .black,
         labelFont: UIFont = .preferredFont(forTextStyle: UIFontTextStyle.title1),
         detailColor: UIColor = .lightGray,
         detailFont: UIFont = .preferredFont(forTextStyle: UIFontTextStyle.caption1),
         accessory: UIImage) {
        self.labelColor = labelColor
        self.labelFont = labelFont
        self.detailColor = detailColor
        self.detailFont = detailFont
        self.accessory = accessory
    }
}

extension CellStyle {
    
    static var settings: CellStyle {
        return CellStyle(labelColor: .purple,
                         labelFont: .preferredFont(forTextStyle: UIFontTextStyle.title1),
                         detailColor: .green,
                         detailFont: .preferredFont(forTextStyle: UIFontTextStyle.caption1),
                         accessory: UIImage(named: "checkmark")!)
    }
}

extension CellStyle {
    
    static var custom: CellStyle {
        // uses default fonts
        return CellStyle(labelColor: .blue,
                         detailColor: .red,
                         accessory: UIImage(named: "action")!)
    }
}
