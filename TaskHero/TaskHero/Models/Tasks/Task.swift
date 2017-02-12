import UIKit

struct Task {
    var taskID: String
    var taskName: String
    var taskDescription:String
    var taskCreated: String
    var taskDue: String
    var taskCompleted: Bool
    var pointValue: Int
}

extension Task {
    init() {
        self.init(taskID: "", taskName: "", taskDescription:"", taskCreated:Date().dateStringFormatted(), taskDue:"", taskCompleted:false, pointValue: 5)
    }
}
