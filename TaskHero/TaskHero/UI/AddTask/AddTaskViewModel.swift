//
//  AddTaskViewModel.swift
//  TaskHero
//

import UIKit

enum ComponentType {
    case months, days, years
}

public struct AddTaskViewModel {
    
    var pickerMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var years = Date().getYears()
    let range: [Int] = Array(1...30)
    
    var month: String = "Feb"
    var day: String = "01"
    var year: String = "2017"
    
    var stringDate: String {
        return "\(month)-\(day)-\(year)"
    }
    
    var numberOfComponents: Int {
        return 3
    }
    
    func setUIInteraction(controller: AddTaskViewController) {
        controller.addTaskView.addTaskButton.addTarget(controller, action: #selector(controller.addTaskButtonTapped), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(controller.dismissKeyboard))
        controller.view.addGestureRecognizer(tap)
    }
}
