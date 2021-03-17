import Foundation
import RealmSwift

class Category: Object
{
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    //Тип Данных (коллекция) самого RealmSwift
    //List <Object> - используется для отношений 'один ко многим'
    let tasks = List<Task>()
    //Как это выглядит в самом swift
    //let tasks: [Task] = []
}
