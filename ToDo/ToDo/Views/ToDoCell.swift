//
//  ToDoCell.swift
//  ToDo
//
//  Created by FERAS on 07/02/2022.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var toDoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        
    }

}
