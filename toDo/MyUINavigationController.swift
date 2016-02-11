//
//  MyUINavigationController.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import CoreData

var context = NSManagedObjectContext()

class MyUINavigationController: UINavigationController, DPHandlesMOC {
    
    
    func receiveMOC(incomingMOC: NSManagedObjectContext) {
        context = incomingMOC
        let child = viewControllers[0] as! protocol<DPHandlesMOC>
        child.receiveMOC(context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
