import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager
{
    static func saveTasksList(_ tasksLists: TasksList)
    {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
    
    static func deleteTasksList(_ tasksLists: TasksList)
    {
        try! realm.write {
            let tasks = tasksLists.tasks
            realm.delete(tasks)
            realm.delete(tasksLists)
        }
    }
    
    static func editTasksList(_ tasksLists: TasksList, newName: String)
    {
        try! realm.write {
            tasksLists.name = newName
        }
    }
    
    static func saveTask(_ tasksLists: TasksList, task: Task)
    {
        try! realm.write {
            tasksLists.tasks.append(task)
        }
    }
    
    static func deleteTask(_ task: Task)
    {
        try! realm.write {
            realm.delete(task)
        }
    }
}

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

class TasksList: Object
{
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    //Тип Данных (коллекция) самого RealmSwift
    //List <Object> - используется для отношений 'один ко многим'
    let tasks = List<Task>()
    //Как это выглядит в самом swift
    //let tasks: [Task] = []
}
