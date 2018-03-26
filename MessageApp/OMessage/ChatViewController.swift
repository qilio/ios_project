//
//  ChatViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/24/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

private struct Constants {
    static let cellIdMessageRecieved = "MessageCellYou"
    static let cellIdMessageSent = "MessageCellMe"
}

class ChatViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var roomId: String!
    var messages: [FIRDataSnapshot] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Room Chat"
        
     /*
        let dissmissKeyboard = UITapGestureRecognizer(target: self, action: #selector(CreateRoomViewController.dissmissKeyboard(_:)))
        dissmissKeyboard.numberOfTapsRequired = 1
        view.addGestureRecognizer(dissmissKeyboard)
    */

        DataService.dataService.fetchMessageFromServer(roomId) { (snap) in
            self.messages.append(snap)
            print(self.messages)
            self.tableView.reloadData()
            
        }
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.showOrHideKeyboard(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.showOrHideKeyboard(_:)), name: UIKeyboardWillShowNotification, object: nil)
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
 
    
  /*
    func dissmissKeyboard(tap: UITapGestureRecognizer){
        view.endEditing(true)
    }*/
    
    // UITextField Delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    
    func showOrHideKeyboard(notification: NSNotification){
        if let keyboardInfo: Dictionary = notification.userInfo{
            if notification.name == UIKeyboardWillShowNotification{
                UIView.animateWithDuration(1, animations: { () in
                    self.constraintToBottom.constant = (keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
                    self.view.layoutIfNeeded()
                }) { (completed: Bool) -> Void in
                    //move to the last msg
                    self.moveToLastMessage()
                }
            }else if notification.name == UIKeyboardWillHideNotification{
                UIView.animateWithDuration(1, animations: { () in
                    self.constraintToBottom.constant = 0
                    self.view.layoutIfNeeded()
                }) { (completed: Bool) -> Void in
                    //move to the last msg
                    self.moveToLastMessage()
                    }
            }
        }
    }
    
    func moveToLastMessage() {
        if self.tableView.contentSize.height > CGRectGetHeight(self.tableView.frame) {
            let contentOfSet = CGPointMake(0, self.tableView.contentSize.height - CGRectGetHeight(self.tableView.frame))
            self.tableView.setContentOffset(contentOfSet, animated: true)
        }
    }

    @IBAction func SendButtonDidTapped(sender: AnyObject) {
        self.chatTextField.resignFirstResponder()
        if chatTextField != "" {
            if let user = FIRAuth.auth()?.currentUser {
                DataService.dataService.CreateNewMessage(user.uid, roomId: roomId, textMessage: chatTextField.text!)
            }else{
                // no user sign in
            }
            
            self.chatTextField.text = nil
        }else{
            print("error: Empty String")
        }
 
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let messageSnapshot = messages[indexPath.row]
        let message = messageSnapshot.value as! Dictionary<String, AnyObject>
        let messageId = message["senderId"] as! String
        if messageId == DataService.dataService.currentUser?.uid{
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdMessageSent, forIndexPath: indexPath) as! ChatTableViewCell
            cell.configCell(messageId, message: message)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdMessageRecieved, forIndexPath: indexPath) as! ChatTableViewCell
            cell.configCell(messageId, message: message)
            return cell
        }
      
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}