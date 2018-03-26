//
//  ProfileTableViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/21/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "EDIT PROFILE"
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(SignUpViewController.selectPhoto(_:)))
        tap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(tap)
        
        //set circle image
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true

        
        if let user = DataService.dataService.currentUser {
            username.text = user.displayName
            email.text = user.email
            print(user.photoURL)
            
            if user.photoURL != nil{
                if let data = NSData(contentsOfURL: user.photoURL!){
                    self.profileImage!.image = UIImage.init(data: data)
                }
            }
            
        }else{
            //no user sign in
        }
    
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func selectPhoto(tap: UITapGestureRecognizer) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            self.imagePicker.sourceType = .PhotoLibrary
        } else{
            self.imagePicker.sourceType = .PhotoLibrary
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    /* func selectPhoto(tap: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }else{
            imagePicker.sourceType = .PhotoLibrary
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    // image picker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profileImage.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   */


    @IBAction func saveDidTapped(sender: AnyObject) {
        var data = NSData()
        data = UIImageJPEGRepresentation(profileImage.image!, 0.1)!
        ProgressHUD.show("Please wait...", interaction: false)
        DataService.dataService.SaveProfile(username.text!, email: email.text!, data: data)
    
    }
    
    
}



extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.profileImage.image = selectedPhoto
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

