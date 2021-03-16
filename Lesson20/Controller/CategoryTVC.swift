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
        
        cell.textLabel?.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.textLabel?.layer.shadowRadius = 7
        cell.textLabel?.layer.shadowOpacity = 1
//        cell.textLabel?.layer.shadowColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.layer.shadowColor = .init(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)

        return cell
    }

    //MARK: - Design
    
    func designBackground()
    {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        
        let backgroundImage = UIImage(named: "backGroundWB2")
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
