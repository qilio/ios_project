//
//  ReminderViewController.swift
//  Todo
//
//  Created by Qili Ou on 7/30/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewController: UIViewController {

    // back button
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    // save button
    @IBAction func saveButton(sender: AnyObject) {
        let alertcontroller = UIAlertController(title: "Congrats", message: "Reminder has been saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
        alertcontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertcontroller, animated: true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    
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
