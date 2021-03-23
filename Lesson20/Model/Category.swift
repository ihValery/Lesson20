import Foundation
import RealmSwift

@objcMembers class Category: Object
{
    dynamic var name = ""
    dynamic var date = Date()
    //Тип Данных (коллекция) самого RealmSwift
    //List <Object> - используется для отношений 'один ко многим'
    let tasks = List<Task>()
    //Как это выглядит в самом swift
    //let tasks: [Task] = []
}
