import Foundation
import RealmSwift

//Так как наследуемся от другого класса Object (typealias Object = RealmSwiftObject)
//Что бы молги определить свои модели как обычные классы Swift
//Class расширяет Object - используется для отношений 'один к одному'
class Task: Object
{
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}
