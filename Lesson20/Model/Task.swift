import Foundation
import RealmSwift

//Так как наследуемся от другого класса Object (typealias Object = RealmSwiftObject)
//Что бы молги определить свои модели как обычные классы Swift
//Class расширяет Object - используется для отношений 'один к одному'
@objcMembers class Task: Object
{
    dynamic var name = ""
    dynamic var note = ""
    dynamic var date = Date()
    dynamic var isComplete = false
}
