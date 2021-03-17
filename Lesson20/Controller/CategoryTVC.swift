import UIKit
import RealmSwift

class CategoryTVC: UITableViewController
{
    //Results это коллекция - в реальном времени
    var tasksLists: Results<TasksList>!
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Получаем живую коллекцию всех задач realm
        tasksLists = realm.objects(TasksList.self)
        title = "Списки"
        designBackground()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData(with: .automatic)
//        tableView.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any)
    {
        alertForAddAndUpdateList()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destination = segue.destination as? TasksTVC else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.currentTasksList = tasksLists[indexPath.row]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tasksLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTasks", for: indexPath)
        let tasksList = tasksLists[indexPath.row]
        cell.textLabel?.text = tasksList.name
        cell.detailTextLabel?.text = "\(tasksList.tasks.count)"
        designCell(with: cell)
        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "edit") { (_, _, completion) in
            self.alertForAddAndUpdateList(self.tasksLists[indexPath.row]) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .destructive, title: "delete") { (_, _, completion) in
            StorageManager.deleteTasksList(self.tasksLists[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash")
        return action
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == .delete {
//            StorageManager.deleteTasksList(tasksLists[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
}
