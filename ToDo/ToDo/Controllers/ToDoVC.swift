//
//  ToDoVC.swift
//  ToDo
//
//  Created by Ferasico on 06/02/2022.
//

import UIKit
import CoreData

class ToDoVC: UIViewController {
    
    var toDoArray:[ToDo] = []
    
    @IBOutlet weak var ToDoTableView: UITableView!
    
    override func viewDidLoad() {
        self.toDoArray = getTodo()
        
        super.viewDidLoad()
        
        
        ToDoTableView.separatorStyle = .none
        
      
        
        // review imported - insert New ToDo
        NotificationCenter.default.addObserver(self, selector: #selector (newToDoAdded), name: NSNotification.Name(rawValue: "AddNewToDo"), object: nil)
        
        // review imported - Edit ToDo
        NotificationCenter.default.addObserver(self, selector: #selector (ToDoEdited), name: NSNotification.Name(rawValue: "CurrentToDoEdited"), object: nil)
        
        
        //review imported - Delete ToDo
        NotificationCenter.default.addObserver(self, selector: #selector (ToDoDeleted), name: NSNotification.Name(rawValue: "ToDoDeleted"), object: nil)
        
        ToDoTableView.dataSource = self
        ToDoTableView.delegate = self
        
    }
    
    
    // review imported - insert New ToDo
    @objc func newToDoAdded(notification: Notification){
        
        if let toDo = notification.userInfo?["AddedToDo"] as? ToDo {
            toDoArray.append(toDo)
            ToDoTableView.reloadData() // اعادة تحميل الجدول
            
            storeToDo(todo: toDo)
        }
        
        // استقبال البيانات من كلاس نيو تودو في سي
        
    }
    
    
    // review imported - Edit ToDo
    @objc func ToDoEdited(notification: Notification){
        
        if let toDo = notification.userInfo?["editToDo"] as? ToDo {
            if let index = notification.userInfo?["editedToDoIndex"] as? Int{
                toDoArray[index] = toDo
                ToDoTableView.reloadData()
            }
             // اعادة تحميل الجدول
        }

}

    
    // review imported - Edit ToDo
    @objc func ToDoDeleted(notification: Notification){
        if let index = notification.userInfo?["DeletedToDoIndex"] as? Int{
            toDoArray.remove(at: index)
                ToDoTableView.reloadData()
            }
             // اعادة تحميل الجدول
        }
    
    
    
    
    func storeToDo(todo: ToDo) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContext = appdelegate.persistentContainer.viewContext
        
        guard let todoEntity = NSEntityDescription.entity(forEntityName: "Todo", in: manageContext) else {return}
        let todoCoreData = NSManagedObject.init(entity: todoEntity, insertInto: manageContext)
        todoCoreData.setValue(todo.title, forKey: "title")
        todoCoreData.setValue(todo.details, forKey: "details")
        
        do{
            try manageContext.save()
            print("===== Success =====")
        } catch{
            print("===== Error =====")
        }
        
    }
    
    func getTodo() -> [ToDo] {
        
        var todos: [ToDo] = []
        
        guard let  appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do{
            let result =  try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for managedTodo in result {
                let title = managedTodo.value(forKey: "title") as! String
                let details = managedTodo.value(forKey: "details") as! String
                let todo = ToDo(title: title, details: details)
                todos.append(todo)
                
                
            }
        } catch{
            print("Error")
        }
        
        return todos
    }
    
    
    

}

//MARK: -
extension ToDoVC: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a new Cell (Object form UITableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        // Get data from our array
        cell.toDoTitle.text = toDoArray[indexPath.row].title
        
        if toDoArray[indexPath.row].image != nil{
            cell.toDoImage.image = toDoArray[indexPath.row].image
        }else {
            cell.toDoImage.image = UIImage(named: "imageDefult")
        }
      
        
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.layer.shadowColor = UIColor.black.cgColor
        cell.viewCell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.viewCell.layer.shadowRadius = 0.9
        cell.viewCell.layer.shadowOpacity = 0.1
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // the shadow disappear
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = toDoArray[indexPath.row]
        
        // Create Oject ToDoDetailsVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoDetailsVC") as? ToDoDetailsVC
        
        if let ToDoDetailsVC = vc {
            ToDoDetailsVC.todo = todo
            ToDoDetailsVC.index = indexPath.row
            navigationController?.pushViewController(ToDoDetailsVC, animated: true)
        }
    }
    
}


