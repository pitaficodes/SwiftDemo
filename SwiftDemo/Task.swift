//
//  MOTask.swift
//  SwiftDemo
//
//  Created by Asad Ali on 08/09/2014.
//  Copyright (c) 2014 DevBatch. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var isCompleted: NSNumber
    
}