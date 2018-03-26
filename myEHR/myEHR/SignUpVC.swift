//
//  SignUpVC.swift
//  myEHR
//
//  Created by Qili Ou on 3/25/18.
//  Copyright © 2018 qilio. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito



class SignUpVC: UIViewController {
    
    @IBOutlet var userNameTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    
    var syncClient: AWSCognito!
    var dataset: AWSCognitoDataset!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //set up title of SignUpVC
        self.title = "Sign Up"
        
        //call hide keyboard function
        self.hideKeyboardWhenTappedAround()
        
        //set up AWS Cognito
        syncClient = AWSCognito.default()
        dataset = syncClient.openOrCreateDataset("myDataset")
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        print("register btn is clicked...")
        print("input User name: \(userNameTxtField.text!)")
        print("input Password: \(passwordTxtField.text!)")
    
        let usernameValue = userNameTxtField.text!
        let passwordValue = passwordTxtField.text!
        

       
        dataset.setString(usernameValue, forKey: "username")
        dataset.setString(passwordValue, forKey: "password")
        
        dataset.synchronize().continueWith { (task: AWSTask!) -> Any? in
            if (task.error == nil) {
                print("successfully saved to AWS Cognito")
                
            }
            return nil
        }
    }
    
}
