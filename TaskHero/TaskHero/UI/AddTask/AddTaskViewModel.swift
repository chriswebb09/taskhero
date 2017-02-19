//
//  AddTaskViewModel.swift
//  TaskHero
//

import UIKit

public struct AddTaskViewModel {
    
    // TODO: - Incomplete needs to accurate data - continue refactoring data out of vc
    
    var pickerMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var years = Date().getYears()
    let range: [Int] = Array(1...30)
    
    var month: String = "Feb"
    var day: String = "01"
    var year: String = "2017"
    
    var stringDate: String {
        return "\(month)-\(day)-\(year)"
    }
}
