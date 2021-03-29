import UIKit

class AlertDeleteCategory
{
    //не использовать СИСТЕМНЫЕ именна
    weak var delegate: ReloadTableDelegate?
    
    func showAlert(_ categoryName: Category, indexPath: IndexPath, on controller: UIViewController)
    {
        let title = "Удалить список\n\(categoryName.name)?"
        let alert = UIAlertController(title: title, message: "Все задачи внутри списка пропадут.\n Это действие нельзя отменить!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            StorageManager.deleteCategory(categoryName)
            
            //
            self.delegate?.tableReloadData()
            print("Проверка")
            
        }))
        controller.present(alert, animated: true)
    }
}
