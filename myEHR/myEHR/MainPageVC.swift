//
//  MainPageVC.swift
//  myEHR
//
//  Created by Qili Ou on 3/26/18.
//  Copyright © 2018 qilio. All rights reserved.
//

import Foundation
import UIKit
import AWSCognito

class MainPageVC: UIViewController {
    
    @IBOutlet var welcomeLbl: UILabel!
    var syncClient: AWSCognito!
    var dataset: AWSCognitoDataset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call hide keyboard function
        self.hideKeyboardWhenTappedAround()
        
        //set up AWS Cognito
        syncClient  = AWSCognito.default()
        dataset = syncClient.openOrCreateDataset("myDataset")
        
        guard let usernameValue = dataset.string(forKey: "username") else {
            print("nothing found!")
            return
        }

        
        self.welcomeLbl.text = "Welcome, \(usernameValue)!"
    }
    
    
}
