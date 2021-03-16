import UIKit
import RealmSwift

class TasksTVC: UITableViewController
{
    var currentTasksList: TasksList!
    
    var openTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = currentTasksList.name
        sortingOpenOrComplited()
        designBackground()
    }
    
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
        
        return cell
    }
    
    //MARK: - Design
    
    func designBackground()
    {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        
    //        clearsSelectionOnViewWillAppear = true
        let backgroundImage = UIImage(named: "backGroundWB2")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
    //    blurView.alpha = 1
        imageView.addSubview(blurView)
        
        //Убираем лишнии линии в таблице
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = .clear
    //        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }
}
