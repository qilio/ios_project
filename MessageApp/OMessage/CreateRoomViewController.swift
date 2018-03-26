//
//  CreateRoomViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/21/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit
import FirebaseAuth


class CreateRoomViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var choosePhotoBtn: UIButton!
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var captionLbl: UITextField!
    
    var selectedPhoto: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dissmissKeyboard = UITapGestureRecognizer(target: self, action: #selector(CreateRoomViewController.dissmissKeyboard(_:)))
        dissmissKeyboard.numberOfTapsRequired = 1
        view.addGestureRecognizer(dissmissKeyboard)
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dissmissKeyboard(tap: UITapGestureRecognizer){
        view.endEditing(true)
    }

    @IBAction func CancelDidTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func selectPhoto_Didtapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else{
            imagePicker.sourceType = .PhotoLibrary
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImg.image = selectedPhoto
        picker.dismissViewControllerAnimated(true, completion: nil)
        choosePhotoBtn.hidden = true
    }
    
    @IBAction func CreateRoomDidTapped(sender: AnyObject) {
        var data: NSData = NSData()
        data = UIImageJPEGRepresentation(photoImg.image!, 0.1)!
        DataService.dataService.CreateNewRoom(FIRAuth.auth()!.currentUser!, caption: captionLbl.text!, data: data)
        dismissViewControllerAnimated(true, completion: nil)
        
    
    
    
    
    }
    
}
