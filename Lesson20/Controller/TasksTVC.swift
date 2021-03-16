import UIKit

class TasksTVC: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}

    //MARK: - Extension

extension TasksTVC
{
    private func alertForAddAndUpdateList()
    {
        let alert = UIAlertController(title: "New task", message: nil, preferredStyle: .alert)
        //Создаем объект UITextField, что бы позже обратиться к placeholder
        var taskTextField: UITextField!
        var noteTextField: UITextField!
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = taskTextField.text, !text.isEmpty else { return }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        alert.addTextField { tf in
            taskTextField = tf
            let list = ["Яйцо", "Молоко", "Печенька", "Вкусняшка"]
            taskTextField.placeholder = list.randomElement()
        }
        alert.addTextField { tf in
            noteTextField = tf
            let list = ["Количество шт.", "Описание"]
            noteTextField.placeholder = list.randomElement()
        }
        present(alert, animated: true)
    }
}
