//
//  ToDoVC.swift
//  ToDo
//
//  Created by Ferasico on 06/02/2022.
//

import UIKit

class ToDoVC: UIViewController {
    
    var toDoArray = [
        ToDo(title: "الذهاب إلى النادي", details: "تم إطلاق عدة معسكرات برمجية بالتعاون مع فريق المحتوى التقني وتحت إشرافه، حيث تم تدريب عدد من الطلاب والطالبات على أهم التقنيات وأكثرها طلبًا في سوق العمل."),
        ToDo(title: "حل واجب طويق ١٠٠٠"),
        ToDo(title: "التواصل مع الناس"),
        ToDo(title: "حف ١٠ كلمات انجليزية"),
        ToDo(title: "مشاهدة معسكر طويق"),
        ToDo(title: "مشاهدة مسلسل اوزارك"),
        ToDo(title: "مشاهدة مباراة الهلال"),
    ]
    
    @IBOutlet weak var ToDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoTableView.dataSource = self
        ToDoTableView.delegate = self
        
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
      
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // the shadow disappear
        tableView.deselectRow(at: indexPath, animated: true)
        let todoIndext = toDoArray[indexPath.row]
        
        // Create Oject ToDoDetailsVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "ToDoDetailsVC") as? ToDoDetailsVC
        
        if let ToDoDetailsVC = vc {
            ToDoDetailsVC.todo = todoIndext
            navigationController?.pushViewController(ToDoDetailsVC, animated: true)
        }
    }
    
}


