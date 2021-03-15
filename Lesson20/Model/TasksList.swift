import RealmSwift

class TasksList: Object
{
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    //Тип Данных (коллекция) самого RealmSwift
    let tasks = List<Task>()
    
    //Как это выглядит в самом swift
    //let tasks: [Task] = []
}
