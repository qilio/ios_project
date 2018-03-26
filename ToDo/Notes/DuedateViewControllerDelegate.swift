//
//  DuedateViewControllerDelegate.swift
//  Todo
//
//  Created by Qili Ou on 8/5/15.
//  Copyright (c) 2015 Qili Ou. All rights reserved.
//


import Foundation


protocol DuedateViewControllerDelegate: class {
    func duedateViewController(controller: DuedateViewController, didFinishWithDate date: NSDate);
}