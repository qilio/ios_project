//
//  ChatTableViewCell.swift
//  OMessage
//
//  Created by Qili Ou on 9/4/16.
//  Copyright © 2016 qilio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    
    }
    
    func configCell(idUser: String, message: Dictionary<String, AnyObject>) {
        self.messageTextLabel.text = message["message"] as? String
        
        DataService.dataService.PEOPLE_REF.child(idUser).observeEventType(.Value, withBlock:{snapshot -> Void in
            let dict = snapshot.value as! Dictionary<String, AnyObject>
            let imageUrl = dict["profileImage"] as! String
            if imageUrl.hasPrefix("gs://") {
                FIRStorage.storage().referenceForURL(imageUrl).dataWithMaxSize(INT64_MAX, completion: { (data, error) in
                    if let error = error {
                        print("Error downloading: \(error)")
                        return
                    }
                    self.profileImageView.image = UIImage.init(data: data!)
                })
            }
        })
      
    }
    
}
