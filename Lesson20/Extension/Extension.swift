import Foundation
import UIKit

extension CategoryTVC
{
    func alertForAddAndUpdateList()
    {
        let alert = UIAlertController(title: "Новый список", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let save = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let newList = alert.textFields?.first?.text, !newList.isEmpty else { return }
            
            let taskList = TasksList()
            taskList.name = newList
            
            StorageManager.saveTasksList(taskList)
            self.tableView.insertRows(at: [IndexPath(row: self.tasksLists.count - 1, section: 0)], with: .automatic)
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        alert.addTextField { tf in
            let list = ["Список покупок", "Список задач", "Список привычек"]
            tf.placeholder = list.randomElement()
        }
        self.present(alert, animated: true)
    }
}

 
extension TasksTVC
{
    func alertForAddAndUpdateTask()
    {
        let alert = UIAlertController(title: "Новый список", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let save = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let newTask = alert.textFields?.first?.text, !newTask.isEmpty else { return }
            
            let task = Task()
            task.name = newTask
            
            if let note = alert.textFields?.last?.text, !note.isEmpty {
                task.note = note
            }
            
            StorageManager.saveTask(self.currentTasksList, task: task)
            self.sortingOpenOrComplited()
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        alert.addTextField { tf in
            let list = ["Яйцо", "Молоко", "Печенька", "Вкусняшка"]
            tf.placeholder = list.randomElement()
        }
        alert.addTextField { tf in
            let list = ["Количество шт.", "Описание"]
            tf.placeholder = list.randomElement()
        }
        self.present(alert, animated: true)
    }
}
