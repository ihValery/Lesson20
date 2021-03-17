import UIKit
import RealmSwift

class TasksTVC: UITableViewController
{
    var currentTasksList: TasksList! {
        didSet {
            self.title = currentTasksList.name
        }
    }
    
    private var openTasks: Results<Task>!
    private var completedTasks: Results<Task>!
    
    
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneTask(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction
    {
        var task: Task!
        task = indexPath.section == 0 ? openTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "edit") { (_, _, completion) in
            self.alertForAddAndUpdateTask(task)
            completion(true)
        }
        action.backgroundColor = .init(red: 50 / 255, green: 183 / 255, blue: 108 / 255, alpha: 1)
        action.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    {
        var task: Task!
        task = indexPath.section == 0 ? openTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let action = UIContextualAction(style: .destructive, title: "delete") { (_, _, completion) in
            StorageManager.deleteTask(task)
            self.sortingOpenOrComplited()
            completion(true)
        }
        action.backgroundColor = .init(red: 242 / 255, green: 86 / 255, blue: 77 / 255, alpha: 1)
        action.image = UIImage(systemName: "trash")
        return action
    }
    
    func doneTask(at indexPath: IndexPath) -> UIContextualAction
    {
        var task: Task!
        task = indexPath.section == 0 ? openTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let action = UIContextualAction(style: .destructive, title: "done") { (_, _, completion) in
            StorageManager.makeDone(task)
            self.sortingOpenOrComplited()
            completion(true)
        }
        action.backgroundColor = .init(red: 50 / 255, green: 186 / 255, blue: 188 / 255, alpha: 1)
        action.image = UIImage(systemName: "checkmark")
        return action
    }
}
