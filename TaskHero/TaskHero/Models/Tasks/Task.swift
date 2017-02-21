import UIKit

struct Task {
    var taskID: String = ""
    var taskName: String = ""
    var taskDescription: String = ""
    var taskCreated: String = Date().dateStringFormatted()
    var taskDue: String = ""
    var taskCompleted: Bool = false
    var pointValue: Int = 5
}
