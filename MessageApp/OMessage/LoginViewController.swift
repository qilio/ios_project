 //
//  LoginViewController.swift
//  OMessage
//
//  Created by Qili Ou on 8/21/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dissmissKeyboard = UITapGestureRecognizer(target: self, action: #selector(CreateRoomViewController.dissmissKeyboard(_:)))
        dissmissKeyboard.numberOfTapsRequired = 1
        view.addGestureRecognizer(dissmissKeyboard)

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dissmissKeyboard(tap: UITapGestureRecognizer){
        view.endEditing(true)
    }

    @IBAction func logInDidTapped(sender: AnyObject) {
        guard let email = emailTxtField.text where !email.isEmpty, let password = passwordTxtField.text where !password.isEmpty else{
            ProgressHUD.showError("Email/Password can't be empty")
            return
        }
        ProgressHUD.show("Signing in...")
        DataService.dataService.logIn(email, password: password)
        
    }
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
