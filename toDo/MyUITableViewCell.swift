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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setInternalFields(entity: ToDoEntity) {
        localToDoEntity = entity
        if localToDoEntity != nil {
            toToTitleLabel.text = localToDoEntity!.toDoTitle

        }
    }

}
