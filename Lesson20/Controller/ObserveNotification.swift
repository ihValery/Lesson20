import UIKit
import RealmSwift

class ObserveNotification
{
    var notificationToken: NotificationToken?
    var category = realm.objects(Category.self)
    
    func changeCollection()
    {
        notificationToken = category.observe { (changes) in
            switch changes {
                case .initial: break
                case .update(_, let deletions, let insertions, let modifications):
                    print("\nDeleted indices: ", deletions)
                    print("Inserted indices: ", insertions)
                    print("Modified modifications: ", modifications, "\n")
                case .error(let error):
                    fatalError("\(error)")
            }
        }
    }
}
