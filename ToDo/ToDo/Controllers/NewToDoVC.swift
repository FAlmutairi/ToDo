//
//  NewToDoVC.swift
//  ToDo
//
//  Created by FERAS on 09/02/2022.
//

import UIKit

class NewToDoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var NewToDoTextField: UITextField!
    @IBOutlet weak var NewDetailsToDo: UITextView!
    @IBOutlet weak var mainButton: UIButton!
    
    // if we create new ToDo
    var isCreation = true
    var editToDo: ToDo?
    var editedToDoIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isCreation{
            mainButton.setTitle("Edit", for: .normal)
            
            if let todo = editToDo{
                NewToDoTextField.text = todo.title
                NewDetailsToDo.text = todo.details
        }
        
        
            
        }
        // Do any additional setup after loading the view.
        NewToDoTextField.delegate = self
        
    }
    

    @IBAction func addNewToDoPressed(_ sender: UIButton) {
        
        if isCreation{
            let todo = ToDo(title: NewToDoTextField.text!, details: NewDetailsToDo.text!)
            // review imported
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddNewToDo"), object: nil, userInfo: ["AddedToDo": todo])
            
            let alert = UIAlertController(title: "Done", message: " have benn added", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ _ in
                self.tabBarController?.selectedIndex = 0
                self.NewToDoTextField.text = ""
                self.NewDetailsToDo.text = ""
            }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
        
            
        } else {
            
            let toDoEdit = ToDo(title: NewToDoTextField.text!, details: NewDetailsToDo.text!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentToDoEdited"), object: nil, userInfo: ["editToDo": toDoEdit, "editedToDoIndex": editedToDoIndex!])
            
            let alert = UIAlertController(title: "Done", message: " have benn Edited", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ _ in
                self.navigationController?.popViewController(animated: true)
                self.NewToDoTextField.text = ""
                self.NewDetailsToDo.text = ""
            }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
            
        }
   
    }

}
