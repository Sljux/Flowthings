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
        
        "id" : [{
            valid, IDValue in
            
            guard let IDValue = IDValue as? String else {
                return valid.addError("id is not of type String")
            }
            
            if IDValue.isShorterThen(8) {
                valid.addError("id String: \(IDValue) seems too short")
            }
            
            }],
        
        "flow_id" : [{
            valid, flow_id in

            guard let flowID = flow_id as? CheckString else {
                return valid.addError("flow_id is not type: String")
            }
            
            if flowID.isShorterThen(5){
                valid.addError("\"flow_id: " + flowID + "\" is too short")
            }
            
            }],
        
        "path" : [{
            valid, path in

            guard let path = path as? CheckString else {
                return valid.addError("path is not type: String")
                
            }
            
            if path.isShorterThen(5){
                valid.addError("\"path: " + path + "\" is too short")
            }
            }],
        
        "elems" : [{
            valid, elems in

            guard let e = elems as? ValidParams else {
                return valid.addError("elems are not of type FlowParams alias: [String:AnyObject]")
            }
            
            let json = JSON(e)
            
            if json.count <= 0 {
                valid.addError("Sending empty elems")
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