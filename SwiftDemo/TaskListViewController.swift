//
//  TaskListViewController.swift
//  SwiftDemo
//
//  Created by Asad Ali on 08/09/2014.
//  Copyright (c) 2014 DevBatch. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
        self.addSomeDummyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addSomeDummyData() {
        
        for (var i = 0; i <= 3; i++) {
            
            let entityDescripition = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext)
            let task = Task(entity: entityDescripition, insertIntoManagedObjectContext: managedObjectContext)
            task.title = "Task \(i)"
            task.isCompleted = false
        }
        
        managedObjectContext.save(nil)

    }

//     #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskTableViewCell
        let task = fetchedResultController.objectAtIndexPath(indexPath) as Task
        
        cell.viewContainer.layer.borderColor = UIColor.blackColor().CGColor
        cell.viewContainer.layer.borderWidth = 2.0
        
        cell.btnIsCompleted.selected = task.isCompleted.boolValue
        cell.btnIsCompleted.tag = indexPath.row
        cell.btnIsCompleted.addTarget(self, action: Selector("btnIsCompletedClicked:"), forControlEvents: .TouchUpInside)

        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: Selector("btnDeleteClicked:"), forControlEvents: .TouchUpInside)
        
        cell.lblTitle.text = task.title
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObject:Task = fetchedResultController.objectAtIndexPath(indexPath) as Task
        let alertTitle = "You just deleted: " + managedObject.title
        
        
        managedObjectContext.deleteObject(managedObject)
        managedObjectContext.save(nil)
        
        showAlertViewWithMessage(alertTitle)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }

    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    
    func btnIsCompletedClicked(sender: AnyObject) {
        
        let button:UIButton = sender as UIButton
        let indexPath = NSIndexPath(forRow: button.tag, inSection: 0)
        
        if !button.selected {
            
            let managedObject:Task = fetchedResultController.objectAtIndexPath(indexPath) as Task
            managedObject.isCompleted = NSNumber(bool: true)
            managedObjectContext.save(nil)
            
            showAlertViewWithMessage("You just Completed: "+managedObject.title)
            
            self.tableView.reloadData()
        }
    }
    
    
    func btnDeleteClicked(sender: AnyObject) {
        
        let button:UIButton = sender as UIButton
        let indexPath = NSIndexPath(forRow: button.tag, inSection: 0)
        
        if !button.selected {
            
            let managedObject:Task = fetchedResultController.objectAtIndexPath(indexPath) as Task
            
            let alertTitle = "You just deleted: " + managedObject.title
            
            managedObjectContext.deleteObject(managedObject)
            managedObjectContext.save(nil)
            
            showAlertViewWithMessage(alertTitle)
            
            self.tableView.reloadData()
        }
    }
    
    func showAlertViewWithMessage(message :String) {
        
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
