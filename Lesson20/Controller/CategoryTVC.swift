import UIKit
import RealmSwift

protocol ReloadTableDelegate: class
{
    func tableReloadData()
}

class CategoryTVC: UITableViewController, ReloadTableDelegate
{
    //Results это коллекция - в реальном времени
    var category: Results<Category>!
    var notification = ObserveNotification()
    var alertDelete = AlertDeleteCategory()

    override func viewDidLoad()
    {
        super.viewDidLoad()
//        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //Получаем живую коллекцию всех задач realm
        category = realm.objects(Category.self)
        title = "Списки"

        notification.reloadTableDelegate = self
        
        notification.changeCollection()
//        tableView.reloadData()
        designBackground()
    }
    
    // MARK: - Navigation
    
    func tableReloadData()
    {
        tableView.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any)
    {
        alertForAddAndUpdateList()
    }
    
    @IBAction func didSelectSorted(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0 {
            category = category.sorted(byKeyPath: "name")
        } else {
            category = category.sorted(byKeyPath: "date")
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destination = segue.destination as? TasksTVC else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.currentCategory = category[indexPath.row]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return category.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTasks", for: indexPath) as! CategoryTVCell
        let categoryIndex = category[indexPath.row]
        cell.configure(with: categoryIndex)
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
            self.alertForAddAndUpdateList(self.category[indexPath.row]) {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            completion(true)
        }
        action.backgroundColor = .init(red: 50 / 255, green: 183 / 255, blue: 108 / 255, alpha: 1)
        action.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let alert = AlertDeleteCategory()
        let action = UIContextualAction(style: .destructive, title: "delete") { (_, _, completion) in
            alert.showAlert(self.category[indexPath.row], indexPath: indexPath, on: self)
            completion(true)
        }
        action.backgroundColor = .init(red: 242 / 255, green: 86 / 255, blue: 77 / 255, alpha: 1)
        action.image = UIImage(systemName: "trash")
        //там где я его созда и подписываю
        alert.delegate = self
        return action
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "done") { (_, _, _) in
            StorageManager.makeAllDone(self.category[indexPath.row])
            self.tableView.reloadData()
//            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        action.backgroundColor = .init(red: 50 / 255, green: 186 / 255, blue: 188 / 255, alpha: 1)
        action.image = UIImage(systemName: "checkmark")
        return action
    }
}
