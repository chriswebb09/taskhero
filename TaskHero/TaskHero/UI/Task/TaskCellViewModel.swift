import UIKit

struct TaskCellViewModel {
    
    var taskName:String
    var taskDescription:String
    var taskDue:String
    var taskCompleted: String
    
    init(_ task:Task) {
        taskName = task.taskName
        taskDescription = task.taskDescription
        taskDue = task.taskDue
        taskCompleted = task.taskCompleted.description
    }
}
