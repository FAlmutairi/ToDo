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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
