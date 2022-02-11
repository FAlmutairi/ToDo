//
//  NewToDoVC.swift
//  ToDo
//
//  Created by FERAS on 09/02/2022.
//

import UIKit

class NewToDoVC: UIViewController {

    @IBOutlet weak var NewToDoTextField: UITextField!
    @IBOutlet weak var NewDetailsToDo: UITextView!
    @IBOutlet weak var mainButton: UIButton!
    
    // if we create new ToDo
    var isCreation = true
    var editToDo: ToDo?
    
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
            let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(closeAction)
            present(alert, animated: true, completion: nil)
        }
   
    }

}


// MARK: - UITextFieldDelegate
extension NewToDoVC: UITextFieldDelegate{
    
//    // This function help us to press return button instead of search button
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(NewToDoTextField.text!)
//        NewToDoTextField.endEditing(true)
//        return true
//    }
//
//
//    //
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//
//        } else {
//            textField.placeholder = "Type something"
//            return false
//        }
//    }
//
//
//    // Use searchTexTField.Text. to got the weather for that city.
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        // To clear TextField after press on search button
//        NewToDoTextField.text = ""
//
//    }
    
}
