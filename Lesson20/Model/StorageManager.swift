import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager
{
    static func saveTasksList(_ tasksLists: [TasksList])
    {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
}

//Так как наследуемся от другого класса Object (typealias Object = RealmSwiftObject)
//Что бы молги определить свои модели как обычные классы Swift
class Task: Object
{
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}

class TasksList: Object
{
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    //Тип Данных (коллекция) самого RealmSwift
    let tasks = List<Task>()
    
    //Как это выглядит в самом swift
    //let tasks: [Task] = []
}
