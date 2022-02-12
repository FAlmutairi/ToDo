//
//  ToDoDetailsVC.swift
//  ToDo
//
//  Created by Ferasico on 07/02/2022.
//

import UIKit

class ToDoDetailsVC: UIViewController {

    @IBOutlet weak var ToDoTitleLeabel: UILabel!
    @IBOutlet weak var ToDoDetailsLabel: UILabel!
    @IBOutlet weak var ToDoImage: UIImageView!
    
    // Definition of the variable as optional from begining better than use optional everyrime when use the variable (save our time)
    
    var todo: ToDo!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if todo.image != nil{
            ToDoImage.image = todo.image
        } else{
            ToDoImage.image = UIImage(named: "imageDefult")
        }
        ToDoDetailsLabel.text = todo.details
        ToDoTitleLeabel.text = todo.title
        
        NotificationCenter.default.addObserver(self, selector: #selector (ToDoEdited), name: NSNotification.Name(rawValue: "CurrentToDoEdited"), object: nil)

        
    }
    
    
    // review imported - Edit ToDo
    @objc func ToDoEdited(notification: Notification){
        
        if let toDo = notification.userInfo?["editToDo"] as? ToDo {
            self.todo = toDo
            self.ToDoDetailsLabel.text = todo.details
            self.ToDoTitleLeabel.text = todo.title
        }

}

    @IBAction func editToDoPressed(_ sender: UIButton) {
        
        if let ViewController = storyboard?.instantiateViewController(withIdentifier: "NewToDoVC") as? NewToDoVC {
            
            ViewController.isCreation = false
            ViewController.editToDo = todo
            ViewController.editedToDoIndex = index
            navigationController?.pushViewController(ViewController, animated: true)
            
        }
        
    }
    
    
    @IBAction func DeletePressed(_ sender: UIButton) {
        
        let confirmAlert = UIAlertController(title: "تنبية", message: " هل انت متاكد من الحذف", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "تأكيد الحذف", style: .destructive) { alert in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToDoDeleted"), object: nil, userInfo: ["DeletedToDoIndex": self.index])
            
            let alert = UIAlertController(title: "Done", message: " have benn Deleted", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
        confirmAlert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancell", style: .cancel, handler: nil)
        confirmAlert.addAction(cancelAction)
        
        self.present(confirmAlert, animated: true, completion: nil)
        
       
        
    }
    
    
}

