import UIKit
import RealmSwift

class CategoryTVCell: UITableViewCell
{
    var category: Category!
    
    @IBOutlet weak var titleCustom: UILabel!
    @IBOutlet weak var subTitleCustom: UILabel!
    @IBOutlet weak var detalCustom: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configure(with category: Category)
    {
        let currentTask = category.tasks.filter("isComplete = false")
        let complitedTask = category.tasks.filter("isComplete = true")
        var allTaskString = ""
        
        titleCustom.text = category.name
        
        
        
        func printArray()
        {
//            var allTaskString = ""
            for item in currentTask {
                allTaskString += "\(item.name): "
//                print(item.name)
            }
            print(allTaskString)
        }
        printArray()
        
        subTitleCustom.text = allTaskString
        
        
        
        if !currentTask.isEmpty {
            detalCustom.text = "\(currentTask.count)"
        } else if !complitedTask.isEmpty {
            detalCustom.text = "✓"
        } else {
            detalCustom.text = "0"
        }
    }
}
