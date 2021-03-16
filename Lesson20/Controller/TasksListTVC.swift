import UIKit

class TasksListTVC: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        designBackground()
        
        let shoppingList = TasksList()
        shoppingList.name = "Shopping List"

        let moviesList = TasksList(value: ["Movies list", Date(), [["Green miles"],["8 miles", "", Date(), true]]])

        let milk = Task()
        milk.name = "Milk"
        milk.note = "2L"

        let bread = Task(value: ["Bread", "", Date(), true])
        let apple = Task(value: ["name": "Apples", "note": "2Kg"/*, "isComplete":"true"*/])

        shoppingList.tasks.append(milk)
        shoppingList.tasks.insert(contentsOf: [bread, apple], at: 1)

        DispatchQueue.main.async
        {
            StorageManager.saveTasksList([shoppingList, moviesList])
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
