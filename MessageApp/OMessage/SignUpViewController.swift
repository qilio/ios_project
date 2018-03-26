//
//  SignUpViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/21/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let dissmissKeyboard = UITapGestureRecognizer(target: self, action: #selector(CreateRoomViewController.dissmissKeyboard(_:)))
        dissmissKeyboard.numberOfTapsRequired = 1
        view.addGestureRecognizer(dissmissKeyboard)
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(SignUpViewController.selectPhoto(_:)))
        tap.numberOfTapsRequired = 1
        profileImage.addGestureRecognizer(tap)
        
        //set circle image
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dissmissKeyboard(tap: UITapGestureRecognizer){
        view.endEditing(true)
    }


    func selectPhoto(tap: UITapGestureRecognizer) {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            self.imagePicker.sourceType = .PhotoLibrary
        } else{
            self.imagePicker.sourceType = .PhotoLibrary
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func CancelDidTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUpDidTapped(sender: AnyObject) {
        guard let email = emailTextField.text where !email.isEmpty, let password = passwordTextField.text where !password.isEmpty, let username = usernameTextField.text where !username.isEmpty else{
            return
        }
        
        var data = NSData()
        data = UIImageJPEGRepresentation(profileImage.image!, 0.1)!
        // Signing up
        
        ProgressHUD.show("Please wait...", interaction: false)
        DataService.dataService.SignUp(username, email: email, password: password, data: data)
        
        
        
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //ImagePicker delegate
    
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
