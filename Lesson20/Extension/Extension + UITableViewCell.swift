import UIKit

extension UITableViewCell
{
    func configure(with tasksList: TasksList)
    {
        let currentTask = tasksList.tasks.filter("isComplete = false")
        let complitedTask = tasksList.tasks.filter("isComplete = true")
        
        textLabel?.text = tasksList.name
        
        if !currentTask.isEmpty {
            detailTextLabel?.text = "\(currentTask.count)"
        } else if !complitedTask.isEmpty {
            detailTextLabel?.text = "✓"
        } else {
            detailTextLabel?.text = "0"
        }
    }
}
