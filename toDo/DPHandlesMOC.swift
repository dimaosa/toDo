//
//  DPHandlesMOC.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DPHandlesMOC {
    
    func receiveMOC(incomingMOC: NSManagedObjectContext)
}

class DPHandlesMOCClass : UIViewController, DPHandlesMOC {
    
    func receiveMOC(incomingMOC: NSManagedObjectContext){}
}