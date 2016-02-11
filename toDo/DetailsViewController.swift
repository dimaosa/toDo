//
//  DetailsViewController.swift
//  toDo
//
//  Created by Osadchy Dima on 2/8/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, DPHandlesMOC, DPHandlesToDoEntity, UITextFieldDelegate, UITextViewDelegate {

    var wasDeleted = false
    
    @IBAction func trashTapped(sender: AnyObject) {
        context.deleteObject(self.localToDoEntity!)
        saveMyToDoEntity()
        wasDeleted = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func TitleFieldEdited(sender: UITextField) {
        print("In TitleFieldEdited DetailsViewController")
        localToDoEntity?.toDoTitle = titleField.text
        saveMyToDoEntity()
        print("Out TitleFieldEdited DetailsViewController")

    }
    @IBOutlet weak var dueDateField: UIDatePicker!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var titleField: UITextField!
    
    var localToDoEntity: ToDoEntity?
    
    override func viewDidLoad() {
        print("In viewDidLoad DetailsViewController")
        
        super.viewDidLoad()
        detailsField.delegate = self
        titleField.delegate = self
        
        print("Out viewDidLoad DetailsViewController")

        
    }
    //when hit enter in textView hide keyboard
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text.containsString("\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        print("In viewWillAppear DetailsViewController")

        super.viewWillAppear(animated)
        
        if (localToDoEntity != nil) {
            titleField.text = localToDoEntity!.toDoTitle
            detailsField.text = localToDoEntity!.toDoDetails
            
        }
        
        print("Out viewWillAppear DetailsViewController")

    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("In viewWillDisappear DetailsViewController")

        super.viewWillDisappear(animated)
        if wasDeleted == false {
            localToDoEntity?.toDoTitle = titleField.text
            localToDoEntity?.toDoDetails = detailsField.text
            saveMyToDoEntity()

        }
        
        print("Out viewWillDisappear DetailsViewController")

    }

    
    func receiveMOC(incomingMOC: NSManagedObjectContext) {
        
        context = incomingMOC
    }
    
    func receiveToDoEntity(incomingToDoEntity: ToDoEntity){
        print("In receiveToDoEntity DetailsViewController")

        localToDoEntity = incomingToDoEntity

        print("Out receiveToDoEntity DetailsViewController")

    }
    
    func saveMyToDoEntity() {
        print("In saveMyToDoEntity DetailsViewController")
        
        do {
            try context.save()
        } catch {
            print("saveFuckedUp")
        }
        
        print("Out saveMyToDoEntity DetailsViewController")

    }

}
