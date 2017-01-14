//
//  NSDate+Extension.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/15/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

//extension NSDate {
//    func dateWithFormat() -> String {
//        let todaysDate = NSDate()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-yyyy"
//        let dateInFormat = dateFormatter.string(from: todaysDate as Date)
//        return dateInFormat
//    }
//}


extension Date {
    func dateStringFormatted() -> String {
        let today = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-yyyy"
        let dateInFormat = dateFormat.string(from: today as Date)
        return dateInFormat
    }
}
