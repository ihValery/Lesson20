import UIKit
import RealmSwift

class TasksTVC: UITableViewController
{
    var currentTasksList: TasksList! {
        didSet {
            self.title = currentTasksList.name
        }
    }
    
    var openTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sortingOpenOrComplited()
        designBackgroundTask()
    }
    
    // MARK: - Navigation
    
    func sortingOpenOrComplited()
    {
        openTasks = currentTasksList.tasks.filter("isComplete = false")
        completedTasks = currentTasksList.tasks.filter("isComplete = true")
        tableView.reloadData()
    }
    @IBAction func addTaskAction(_ sender: Any)
    {
        alertForAddAndUpdateTask()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return section == 0 ? openTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return section == 1 ? "завершенные" : nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        
        var task: Task!
        task = indexPath.section == 0 ? openTasks[indexPath.row] : completedTasks[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.note
        
        cell.accessoryType = task.isComplete ? .checkmark : .none
        designCell(with: cell)
        
        return cell
    }
    
    //MARK: - Table view delegate
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == .delete {
//            StorageManager.deleteTask(currentTasksList[indexPath.row] as! Task)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
}
