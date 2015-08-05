//
//  Group.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation


struct Group {
    
    var id : String?
    // Group ID
    
    var displayName : String?
    // A descriptive name for the Group
    
    var description : String?
    // Further information used to describe the Group
    
    var memberIds : [String]?
    // A list of Identity IDs corresponding to the members of the Group.
    
    func create(){}
    func read(){}
    func find(){}
    func update(){}
    func delete(){}
}