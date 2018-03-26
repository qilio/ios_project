//
//  Tasktitle.swift
//  Todo
//
//  Created by Qili Ou on 8/5/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//

import Foundation
import CoreData

class Tasktitle: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var lists: NSSet
   
    @NSManaged var note: Notes

}
