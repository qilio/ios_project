//
//  LIstsTableViewController.swift
//  Todo
//
//  Created by Qili Ou on 8/5/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import Foundation
import CoreData

class Lists: NSManagedObject {

    @NSManaged var duedate: String
    @NSManaged var reminder: String
    @NSManaged var title: String
    
    @NSManaged var tasktitle:  Tasktitle

}
