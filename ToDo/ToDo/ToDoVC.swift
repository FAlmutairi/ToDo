//
//  ToDoVC.swift
//  ToDo
//
//  Created by Ferasico on 06/02/2022.
//

import UIKit

class ToDoVC: UIViewController {
    
    var toDoArray = ["First Day", "Secend Day", "Third Day", "Fourth Day"]
    
    @IBOutlet weak var ToDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoTableView.dataSource = self
        
    }

}


//MARK: -
extension ToDoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a new Cell (Object form UITableView)
        let cell = UITableViewCell()
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
        
    }
}


