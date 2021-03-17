import Foundation
import UIKit

extension CategoryTVC
{
    public func alertForAddAndUpdateList(_ listName: TasksList? = nil, completion: (() -> Void)? = nil)
    {
        let title = listName == nil ? "Новый список" : "Хотите изменить?"
        let titleButton = listName == nil ? "Добавить" : "Изменить"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let save = UIAlertAction(title: titleButton, style: .default) { _ in
            guard let newList = alert.textFields?.first?.text, !newList.isEmpty else { return }
            
            if let listName = listName {
                StorageManager.editTasksList(listName, newName: newList)
                //Оставил поле пусты - ничего не делаем
                if completion != nil { completion!() }
            } else {
                let taskList = TasksList()
                taskList.name = newList
                
                StorageManager.saveTasksList(taskList)
//                self.tableView.insertRows(at: [IndexPath(row: self.tasksLists.count - 1, section: 0)], with: .automatic)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { tf in
            let list = ["Список покупок", "Список задач", "Список привычек"]
            tf.placeholder = list.randomElement()
        }
        
        if let listName = listName {
            alert.textFields?.first?.text = listName.name
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        self.present(alert, animated: true)
    }
    
    public func designBackground()
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
    }
}

extension TasksTVC
{
    public func alertForAddAndUpdateTask(_ taskName: Task? = nil)
    {
        let title = taskName == nil ? "Новый список" : "Хотите изменить?"
        let titleButton = taskName == nil ? "Добавить" : "Изменить"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let save = UIAlertAction(title: titleButton, style: .default) { _ in
            guard let newTask = alert.textFields?.first?.text, !newTask.isEmpty else { return }
            
            if let taskName = taskName {
                if let newNote = alert.textFields?.last?.text, !newNote.isEmpty {
                    StorageManager.editTask(taskName, newName: newTask, newNote: newNote)
                } else {
                    StorageManager.editTask(taskName, newName: newTask, newNote: "")
                }
                self.sortingOpenOrComplited()
            } else {
                let task = Task()
                task.name = newTask
                
                if let note = alert.textFields?.last?.text, !note.isEmpty {
                    task.note = note
                }
                
                StorageManager.saveTask(self.currentTasksList, task: task)
                self.sortingOpenOrComplited()
            }
        }
        
        alert.addTextField { tf in
            let list = ["Яйцо", "Молоко", "Печенька", "Вкусняшка"]
            tf.placeholder = list.randomElement()
            
            if let taskName = taskName {
                alert.textFields?.first?.text = taskName.name
            }
        }
        alert.addTextField { tf in
            let list = ["Количество шт.", "Описание"]
            tf.placeholder = list.randomElement()
            
            if let taskName = taskName {
                alert.textFields?.last?.text = taskName.note
            }
        }

        alert.addAction(cancel)
        alert.addAction(save)
        self.present(alert, animated: true)
    }
    
    public func designBackgroundTask()
    {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        
        let backgroundImage = UIImage(named: "backGroundWB2")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        //Убираем лишнии линии в таблице
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = .clear
    }
}

public func designCell(with cell: UITableViewCell)
{
    cell.textLabel?.layer.shadowOffset = CGSize(width: 1, height: 1)
    cell.textLabel?.layer.shadowRadius = 7
    cell.textLabel?.layer.shadowOpacity = 1
    cell.textLabel?.layer.shadowColor = .init(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
}

public extension StringProtocol
{
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
