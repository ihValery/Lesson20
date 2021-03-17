import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager
{
    static func saveTasksList(_ tasksLists: Category)
    {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
    
    static func deleteTasksList(_ tasksLists: Category)
    {
        try! realm.write {
            let tasks = tasksLists.tasks
            //Удаляем сразу задачи, а следом и сам список (в ином случаеи упадет приложение)
            realm.delete(tasks)
            realm.delete(tasksLists)
        }
    }
    
    static func editTasksList(_ tasksLists: Category, newName: String)
    {
        try! realm.write {
            tasksLists.name = newName
        }
    }
    
    static func saveTask(_ tasksLists: Category, task: Task)
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
    
    static func editTask(_ task: Task, newName: String, newNote: String)
    {
        try! realm.write {
            task.name = newName
            task.note = newNote
        }
    }
    
    static func makeDone(_ task: Task)
    {
        try! realm.write {
            task.isComplete.toggle()
        }
    }
    
    static func makeAllDone(_ tasksList: Category)
    {
        try! realm.write {
            tasksList.tasks.setValue(true, forKey: "isComplete")
        }
    }
}
