//
//  MyUITableViewCell.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class MyUITableViewCell: UITableViewCell {

    @IBOutlet weak var toToTitleLabel: UILabel!
    var localToDoEntity: ToDoEntity?
    
    @IBOutlet weak var toDoPriorityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setInternalFields(entity: ToDoEntity) {
        localToDoEntity = entity
        if localToDoEntity != nil {
            toToTitleLabel.text = localToDoEntity!.toDoTitle
            let priority = Priority(rawValue: (localToDoEntity!.toDoPriority?.integerValue)!)!
            var toDoPriorityLabelText = ""
            switch priority {
            case .None:
                toDoPriorityLabelText = ""
                break
            case .Low:
                toDoPriorityLabel.textColor = .blueColor()
                toDoPriorityLabelText = "!"
                break
            case .Medium:
                toDoPriorityLabel.textColor = .purpleColor()
                toDoPriorityLabelText = "!!"
                break
            case .High:
                toDoPriorityLabel.textColor = .redColor()
                toDoPriorityLabelText = "!!!"
                break
            }

            toDoPriorityLabel.text = "\(toDoPriorityLabelText)"
        }
        
    }

}
