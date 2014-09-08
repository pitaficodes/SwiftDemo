//
//  NewTaskViewController.swift
//  SwiftDemo
//
//  Created by Asad Ali on 08/09/2014.
//  Copyright (c) 2014 DevBatch. All rights reserved.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtTitle : UITextField
    @IBOutlet var btnDone : UIBarButtonItem
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    init(coder aDecoder: NSCoder!) {
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtTitle.delegate = self
        self.btnDone.enabled = false
        self.txtTitle.addTarget(self, action: Selector("checkInputCount"), forControlEvents: .EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func done(sender: AnyObject) {
        
        if self.txtTitle.text.bridgeToObjectiveC().length > 0 {
            
            let entityDescripition = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext)
            let task = Task(entity: entityDescripition, insertIntoManagedObjectContext: managedObjectContext)
            task.title = self.txtTitle.text
            task.isCompleted = false
            managedObjectContext.save(nil)
            
            popViewController()
        }
        else
        {
            var alert = UIAlertController(title: "Alert", message: "Please enter title first", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        popViewController()
    }
    
    func popViewController() {
        navigationController.popViewControllerAnimated(true)
    }

    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func checkInputCount() {
        
        self.btnDone.enabled = self.txtTitle.text.bridgeToObjectiveC().length > 0
    }
    
}
