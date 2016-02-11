//
//  MyTableViewController.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController:
    UITableViewController,
    DPHandlesMOC,
    NSFetchedResultsControllerDelegate
{

    @IBOutlet weak var toDoDateLabel: UILabel!
    @IBOutlet weak var toDoTitleLabel: UILabel!
    
    var resultController = NSFetchedResultsController()

    
    override func viewDidLoad() {
        print("In viewDidLoad")

        super.viewDidLoad()

        initializeFetchedResultsControllerDelegate()
        

        print("Out viewDidLoad")

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultController.sections![section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("In tableView cellForRowAtIndexPath")
        let item = resultController.sections![indexPath.section].objects![indexPath.row] as! ToDoEntity
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.TableCellIdentifier, forIndexPath: indexPath) as? MyUITableViewCell

        cell!.setInternalFields(item)
        print("Out tableView cellForRowAtIndexPath")

        return cell!
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let item = resultController.objectAtIndexPath(indexPath) as! ToDoEntity
            context.deleteObject(item)
            do{
                try context.save()
            } catch {
                print("Save fuck's when row was deleted")
            }
        }
    }


    
//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("In prepareForSegue")
        
        let child = segue.destinationViewController as! protocol<DPHandlesMOC, DPHandlesToDoEntity>
        child.receiveMOC(context)

        if let identifier = segue.identifier {
            switch identifier {
                
                
            case Constants.SegueAddToDoIdentifier:
                print("Segue = \(Constants.SegueAddToDoIdentifier)")
                let item = NSEntityDescription.insertNewObjectForEntityForName(Constants.ToDoEntityName, inManagedObjectContext: context) as! ToDoEntity
                child.receiveToDoEntity(item)

                break
                
            case Constants.SegueEditToDoIdentifier:
                print("Segue = \(Constants.SegueEditToDoIdentifier)")
                
                let item = (sender as? MyUITableViewCell)?.localToDoEntity
                child.receiveToDoEntity(item!)
                break
            default:
                break
            }
        }

        print("Out prepareForSegue")

        
    }


    func receiveMOC(incomingMOC: NSManagedObjectContext) {
        context = incomingMOC
    }
    
    struct Constants {
        static let ToDoEntityName = "ToDoEntity"
        static let ToDoEntityTitle = "toDoTitle"
        static let TableCellIdentifier = "TableCellIdentifier"
        static let SegueEditToDoIdentifier = "editToDo"
        static let SegueAddToDoIdentifier = "addToDo"
    }
    
    
    func initializeFetchedResultsControllerDelegate() {
        print("In initializeFetchedResultsControllerDelegate")

        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(Constants.ToDoEntityName, inManagedObjectContext: context)
        
        fetchRequest.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "toDoPriority", ascending: false)]

        
        
        
        resultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        resultController.delegate = self
        
        do {
            try resultController.performFetch()
        } catch {
            print("Fuck's in MyTableViewController")
        }
        
        print("Out initializeFetchedResultsControllerDelegate")

        
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            break
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            break
        case .Update:
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! MyUITableViewCell
            let item = controller.objectAtIndexPath(indexPath!) as! ToDoEntity
            cell.setInternalFields(item)
            break
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            break
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
}
