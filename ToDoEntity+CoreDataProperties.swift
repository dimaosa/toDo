//
//  ToDoEntity+CoreDataProperties.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDoEntity {
    @NSManaged var toDoTitle: String?
    @NSManaged var toDoDetails: String?
    @NSManaged var toDoDueDate: NSDate?

}
