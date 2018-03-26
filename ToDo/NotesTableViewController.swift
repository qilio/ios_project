//
//  NotesTableViewController.swift
//  2Do
//
//  Created by Qili Ou on 7/28/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    @IBOutlet var taskTV: UITableView!
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var selected = taskTV.indexPathForSelectedRow()?.row
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var managedContext = appDelegate.managedObjectContext!
        
        var fetchRequest = NSFetchRequest(entityName: "Notes")
        fetchRequest.returnsDistinctResults = false
        var error : NSError?
      
        var fetchedResults:NSArray = managedContext.executeFetchRequest(fetchRequest, error: nil)!
        
        
        if segue.identifier == "link1" {
            /*var svc = segue.destinationViewController as! ListsTableViewController
            svc.passValue = self.passValue
            */
            var selected = notes [self.taskTV.indexPathForSelectedRow()!.row] as! Notes
            let VC: ListsTableViewController = segue.destinationViewController as! ListsTableViewController
            VC.titlename = selected
            
        }
    }
    
    
    var notes = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manegedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Notes")
        
        var error : NSError?
        let fetchedResults = manegedContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if let results = fetchedResults {
            notes = results
        }
        else {
            println(error)
        }
        self.tableView.reloadData()
    }

    @IBAction func addButton(sender: AnyObject) {
        let alertcontroller = UIAlertController(title: "Add New", message: "Please add a task", preferredStyle:UIAlertControllerStyle.Alert)
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertcontroller.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            
            let textField = alertcontroller.textFields![0] as! UITextField
            self.saveNotes(textField.text)
            self.tableView.reloadData()
        }))

        alertcontroller.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            
        }
        
        self.presentViewController(alertcontroller, animated: true, completion: nil)
        
    
    }
    
    func saveNotes (note: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manegedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Notes", inManagedObjectContext: manegedContext!)
        
        let title = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: manegedContext)
        
        title.setValue(note, forKey: "title")
               
        var error : NSError?
        if(manegedContext?.save(&error) == nil) {
            println(error)
        }
        
        notes.append(title)
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return notes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
            cell.textLabel!.text = notes[indexPath.row].valueForKey("title") as! String?
        
            return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let manegedContext = appDelegate.managedObjectContext
            
            manegedContext?.deleteObject(notes[indexPath.row] as NSManagedObject)
            notes.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            var error : NSError?
            if(manegedContext?.save(&error) == nil) {
                println(error)
            }
        }
        else if editingStyle == .Insert {
            //not implemented
        }
    
    }


}

