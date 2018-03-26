//
//  ViewController.swift
//  myEHR
//
//  Created by Qili Ou on 3/25/18.
//  Copyright © 2018 qilio. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito

class SignInVC: UIViewController {

    @IBOutlet var userNameTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    
    
    var syncClient: AWSCognito!
    var dataset: AWSCognitoDataset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call hide keyboard function
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set up AWS Cognito
        syncClient  = AWSCognito.default()
        dataset = syncClient.openOrCreateDataset("myDataset")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtnClicked(_ sender: Any) {
        
        print("Sign In Btn is clicked...")
        print("input User name: \(userNameTxtField.text!)")
        print("input Password: \(passwordTxtField.text!)")

        //fetech AWS Cognito data
        guard let usernameValue = dataset.string(forKey: "username") else {
            print("nothing found!")
            return
        }
        guard let passwordValue = dataset.string(forKey: "password") else {
            print("nothing found!")
            return
        }
        
        print("stored user name: \(usernameValue)")
        print("stored password: \(passwordValue)")
        
        
        // check matching information for logIn
        if usernameValue == userNameTxtField.text! && passwordValue == passwordTxtField.text! {
            // go to mainPage VC
            self.performSegue(withIdentifier: "toMainPage", sender: nil)
        } else {
            let alert = UIAlertController(title: "Sorry", message: "You input an unmatched information, please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
    
    @IBAction func dontHaveActBtnClicked(_ sender: Any) {
        //go to signUp VC
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
}

