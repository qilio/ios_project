//
//  DetailsViewController.swift
//  Todo
//
//  Created by Qili Ou on 7/30/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DuedateViewControllerDelegate {

    
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var reMinder: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var textinput: String = ""
    var existingItem: NSManagedObject!

    func duedateViewController(controller: DuedateViewController, didFinishWithDate date: NSDate) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
     //   var strDate = dateFormatter.stringFromDate("\(date)")
      //  self.dueDate.text = strDate
        dueDate.text = "\(date)"
    }
    
    override func viewDidLoad() {

    super.viewDidLoad()
    var appdel = (UIApplication.sharedApplication().delegate as! AppDelegate)
    var context = appdel.managedObjectContext
    
    var temp = NSFetchRequest(entityName: "Lists")
    //for
    //dueDate = context!.executeFetchRequest(temp, error: nil)
    
    if (existingItem != nil)
    {
        textField.text = textinput
    }
    // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // back button
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
   
    // create button
    @IBAction func createButton(sender: AnyObject) {
        
        // reference to our app delegate
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // reference Model
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("Tasktitle", inManagedObjectContext: context)
        
        
        //check if item exists
        
        if (existingItem != nil)
        {
            existingItem.setValue(textField.text as String, forKey: "title")
            println("Value changed to : \(existingItem)")
        }
        else
        {
            
        // create instance of our data and initializ
        var newItem = Tasktitle (entity : en!, insertIntoManagedObjectContext : context)
            
        // map our property
        newItem.title = textField.text
        newItem.note = selectedNote
        
            
            
            
        println(newItem)
        }
        
        // save our content
        context.save(nil)
//---------------------------------------------------------------------------
        
        for element in selectedNote.tasktitles.allObjects as! [Tasktitle] {
        
            println("\(element)------------------------299999999999999999")
        }
        
        println("\(selectedNote.tasktitles.count)-----------------------")
//----------------------------------------------------------------------------
        
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    var selectedNote: Notes!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("DueDateSettingSegue"):
            let duedateViewController = segue.destinationViewController as! DuedateViewController
            duedateViewController.delegate = self
        default:
            super.prepareForSegue(segue, sender: sender)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
