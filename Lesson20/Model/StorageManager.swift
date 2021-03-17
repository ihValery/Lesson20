import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager
{
    static func saveCategory(_ category: Category)
    {
        try! realm.write {
            realm.add(category)
        }
    }
    
    static func deleteCategory(_ category: Category)
    {
        try! realm.write {
            let tasks = category.tasks
            //Удаляем сразу задачи, а следом и сам список (в ином случаеи упадет приложение)
            realm.delete(tasks)
            realm.delete(category)
        }
    }
    
    static func editCategory(_ category: Category, newName: String)
    {
        try! realm.write {
            category.name = newName
        }
    }
    
    static func saveTask(_ category: Category, task: Task)
    {
        try! realm.write {
            category.tasks.append(task)
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
    
    static func makeAllDone(_ category: Category)
    {
        try! realm.write {
            category.tasks.setValue(true, forKey: "isComplete")
        }
    }
}
