import UIKit
import RealmSwift

class CategoryTVCell: UITableViewCell
{
    var tastasksList: TasksList!
    
    @IBOutlet weak var titleCustom: UILabel!
    @IBOutlet weak var subTitleCustom: UILabel!
    @IBOutlet weak var detalCustom: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    func configure(with tasksList: TasksList)
    {
        let currentTask = tasksList.tasks.filter("isComplete = false")
        let complitedTask = tasksList.tasks.filter("isComplete = true")
        
        titleCustom.text = tasksList.name
        subTitleCustom.text = "Вывести весь список задач!"
        
        if !currentTask.isEmpty {
            detalCustom.text = "\(currentTask.count)"
        } else if !complitedTask.isEmpty {
            detalCustom.text = "✓"
        } else {
            detalCustom.text = "0"
        }
    }
}
