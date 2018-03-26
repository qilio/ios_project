//
//  ListsTableViewController.swift
//  2Do
//
//  Created by Qili Ou on 7/28/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import UIKit
import CoreData

class ListsTableViewController: UITableViewController {
   
    //back button
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    
    }
    
    var lists: Array<AnyObject> = []
    /*var passValue = ""*/
    var titlename: Notes!

    override func viewDidAppear(animated: Bool)
    {
        self.updateTitle.title = titlename.title
       /* self.updateTitle.title = passValue*/
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext!

        //let fetchRequet = passValue
        
        let temp = NSFetchRequest(entityName: "Tasktitle")
        temp.predicate = NSPredicate(format: "note == %@", titlename)
        
        lists = context.executeFetchRequest(temp, error: nil)!
        tableView.reloadData()
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
        return lists.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        //new
        
     
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier1") as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath?
        {
            var data : NSManagedObject = lists[ip.row] as! NSManagedObject
            cell.textLabel!.text = data.valueForKeyPath("title") as? String
            
    //      var dd  = data.valueForKey("duedate") as! String
    //      var rmd = data.valueForKey("reminder") as! String
            
    //      cell.detailTextLabel?.text = "due date is: \(dd)  -   reminder time is: \(rmd)"
        }

        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBOutlet weak var updateTitle: UINavigationItem!
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            if let tv = tableView as UITableView?
            {
                context.deleteObject(lists[indexPath.row] as! NSManagedObject)
                lists.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var  error : NSError? = nil
            if !context.save(&error)
            {
                abort()
            }
        }

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if let identifier = segue.identifier where identifier == "addItem" {
            let DVC : DetailsViewController = segue.destinationViewController as! DetailsViewController
            DVC.selectedNote = titlename
        }
        
        if segue.identifier == "link2"
        {
            var selectedItem : NSManagedObject = (lists[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject) as NSManagedObject
            
            let DVC : DetailsViewController = segue.destinationViewController as! DetailsViewController
            
            DVC.textinput = selectedItem.valueForKey("title") as! String
            DVC.existingItem = selectedItem
            
        }
        
    }

    
}

