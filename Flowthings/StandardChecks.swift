//
//  StandardChecks.swift
//  Flowthings
//
//  Created by Ceco on 8/19/15.
//  Copyright © 2015 cityos. All rights reserved.
//

// RUN THIS OUTSIDE
//guard let e = elems as? ValidParams else {
//    valid.addMessage("elems are not: [String:AnyObject]")
//    valid.isValid = false
//    return
//}

public struct StandardChecks {
    
    public var run : ValidChecks = [
        
        "flow_id" : [{
            valid, flow_id in
            
            guard let flowID = flow_id as? CheckString else {
                return valid.addError("flow_id is not type: String")
            }
            
            if flowID.isShorterThen(5){
                valid.addMessage("\"flow_id: " + flowID + "\" is too short")
                valid.isValid = false
            }
            }],
        
        "path" : [{
            valid, path in
            
            guard let path = path as? CheckString else {
                valid.addMessage("path is not type: String")
                valid.isValid = false
                return
            }
            
            if path.isShorterThen(5){
                valid.addMessage("\"path: " + path + "\" is too short")
                valid.isValid = false
            }
            }]
    ]

    mutating func update(more:ValidChecks) {
        for (key,value) in more {
            run[key] = value
        }
    }
}

//func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
//    for (k, v) in right {
//        left.updateValue(v, forKey: k)
//    }
//}