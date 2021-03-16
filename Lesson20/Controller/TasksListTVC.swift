import UIKit
import RealmSwift

class TasksListTVC: UITableViewController
{
    //Results это коллекция - в реальном времени
    var tasksLists: Results<TasksList>!
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Получаем живую коллекцию всех задач realm
        tasksLists = realm.objects(TasksList.self)
        designBackground()
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

        return cell
    }

    //MARK: - Design
    
    func designBackground()
    {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        
        let backgroundImage = UIImage(named: "backGroundWB")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
        
        //Убираем лишнии линии в таблице
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = .clear
//        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }
}

    //MARK: - Extension

extension TasksListTVC
{
    private func alertForAddAndUpdateList()
    {
        let alert = UIAlertController(title: "New list", message: nil, preferredStyle: .alert)
        //Создаем объект UITextField, что бы позже обратиться к placeholder
        var alertTextField: UITextField!
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = alertTextField.text, !text.isEmpty else { return }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(save)
        alert.addAction(cancel)
       
        alert.addTextField { tf in
            alertTextField = tf
            let list = ["Список покупок", "Список задач"]
            alertTextField.placeholder = list.randomElement()
        }
        present(alert, animated: true)
    }
}
