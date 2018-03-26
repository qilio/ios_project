 //
//  RoomCollectionViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/21/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

//private let reuseIdentifier = "Cell"

class RoomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var rooms = [Room]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        DataService.dataService.fetchDataFromServer{ (room) in
            self.rooms.append(room)
            let indexPath = NSIndexPath(forItem: self.rooms.count - 1, inSection: 0)
            self.collectionView?.insertItemsAtIndexPaths([indexPath])
        
        */
        DataService.dataService.ROOM_REF.observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            let room = Room(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>)
            self.rooms.append(room)
            let indexPath = NSIndexPath(forItem: self.rooms.count - 1, inSection: 0)
            self.collectionView?.insertItemsAtIndexPaths([indexPath])
        
        })
  }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.

/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
/*
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return rooms.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("roomCell", forIndexPath: indexPath) as! RoomCollectionViewCell
    
        // Configure the cell
        let room = rooms[indexPath.row]
        cell.configureCell(room) 
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.size.width / 2 - 5, view.frame.size.width / 2 - 5)
    }

   
    @IBAction func logout(sender: AnyObject) {
        let actionSheetController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) in
            print("Cancel")
            
        }
        actionSheetController.addAction(cancelActionButton)
        
        let profileActionButton = UIAlertAction(title: "Profile", style: UIAlertActionStyle.Default) { (action) in
            let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfile") as! ProfileTableViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
        
        }
        
        actionSheetController.addAction(profileActionButton)
        let logoutAction = UIAlertAction(title: "Log Out", style: UIAlertActionStyle.Default) { (action) in
            print("log out")
            self.logoutDidTapped()
            
        }

        actionSheetController.addAction(logoutAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    
    }
 
    func logoutDidTapped() {
        
        DataService.dataService.logout()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChatSegue" {
            let cell = sender as! RoomCollectionViewCell
            let indexPath = collectionView?.indexPathForCell(cell)
            let room = rooms[indexPath!.item]
            let chatViewController = segue.destinationViewController as! ChatViewController
            chatViewController.roomId = room.id
            
        }
    }
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
