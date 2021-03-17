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
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    @IBAction func addAction(_ sender: Any)
    {
        alertForAddAndUpdateList()
    }
    
//    @IBAction func didSelectSorted(_ sender: UISegmentedControl)
//    {
//        if sender.selectedSegmentIndex == 0 {
//            tasksLists = tasksLists.sorted(byKeyPath: "name")
//        } else {
//            tasksLists = tasksLists.sorted(byKeyPath: "date", ascending: false)
//        }
//        tableView.reloadData()
//    }
    
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
        let done = doneAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit, done])
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "edit") { (_, _, completion) in
            self.alertForAddAndUpdateList(self.tasksLists[indexPath.row]) {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            completion(true)
        }
        action.backgroundColor = #colorLiteral(red: 0.1961711347, green: 0.7188495994, blue: 0.4251968861, alpha: 1)
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
        action.backgroundColor = #colorLiteral(red: 0.9508683085, green: 0.3361024261, blue: 0.3030498922, alpha: 1)
        action.image = UIImage(systemName: "trash")
        return action
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "done") { (_, _, completion) in
            StorageManager.makeAllDone(self.tasksLists[indexPath.row])
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = #colorLiteral(red: 0.1957473755, green: 0.7305807471, blue: 0.7368780971, alpha: 1)
        action.image = UIImage(systemName: "checkmark")
        return action
    }
}
