//
//  DuedateViewController.swift
//  Todo
//
//  Created by Qili Ou on 7/30/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import UIKit
import CoreData

class DuedateViewController: UIViewController {

    weak var delegate: DuedateViewControllerDelegate?
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    //back button
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //save button
    @IBAction func saveButton(sender: AnyObject) {
/*        var appdel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context = appdel.managedObjectContext
        var temp = NSEntityDescription.insertNewObjectForEntityForName("Lists", inManagedObjectContext: context!) as! NSManagedObject
        
        temp.setValue(myDatePicker.date, forKey: "dueDate")
        context?.save(nil)
*/
        // pick the date data
        delegate?.duedateViewController(self, didFinishWithDate: myDatePicker.date)
        
        
        let alertcontroller = UIAlertController(title: "Congrats", message: "Due date has been saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
        alertcontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertcontroller, animated: true, completion: nil)
        
        
        
        
       
    }
    
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
//        var strDate = dateFormatter.stringFromDate(myDatePicker.date)
     //   DetailsViewController.dueDate.text = strDate
    //    delegate?.duedateViewController(self, didFinishWithDate: myDatePicker.date)

    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
