//
//  NotesTableViewController.swift
//  Todo
//
//  Created by Qili Ou on 8/5/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import Foundation
import CoreData

class Notes: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var tasktitles: NSSet

}
