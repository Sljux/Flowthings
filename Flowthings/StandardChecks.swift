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
        
        "id" : [{ valid, IDValue in
            
            guard let IDValue = StandardChecks.checkTypes(valid, path: "id", value: IDValue, type: String.self) else {
                return
            }
            
            if IDValue.isShorterThen(8) {
                valid.addError("id String: \(IDValue) seems too short")
            }
            
        }],
        
        "flow_id" : [{ valid, flow_id in

            guard let flowID = StandardChecks.checkTypes(valid, path: "flow_id", value: flow_id, type: String.self) else {
                return
            }
            
            if flowID.isShorterThen(5) {
                valid.addError("\"flow_id: " + flowID + "\" is too short")
            }
            
        }],
        
        "path" : [{ valid, path in

            guard let path = StandardChecks.checkTypes(valid, path: "path", value: path, type: String.self) else {
                return
            }
            
            if path.isShorterThen(5) {
                valid.addError("\"path: " + path + "\" is too short")
            }
        }],
        
        "elems" : [{ valid, elems in

            guard let e = StandardChecks.checkTypes(valid, path: "elems", value: elems, type: ValidParams.self) else {
                return
            }
            
            let json = JSON(e)
            
            if json.count <= 0 {
                valid.addError("Sending empty elems")
            }
            
        }],
        
        "source" : [{ valid, source in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "source", value: source, type: String.self) else {
                return
            }
            
        }],
        
        "destination" : [{ valid, destination in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "destination", value: destination, type: String.self) else {
                return
            }
            
        }],
        
        "groupBy" : [{ valid, groupBy in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "groupBy", value: groupBy, type: [String].self) else {
                return
            }
            
        }],
        
        "output" : [{ valid, output in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "output", value: output, type: [String].self) else {
                return
            }
            
        }],
        
        "paths" : [{ valid, paths in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "paths", value: paths, type: ValidParams.self) else {
                return
            }
            
        }],
        
        "memberIds" : [{ valid, memberIds in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "memberIds", value: memberIds, type: [String].self) else {
                return
            }
            
        }],
        
        "js" : [{ valid, js in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "js", value: js, type: String.self) else {
                return
            }
            
        }],
        
        "url" : [{ valid, url in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "url", value: url, type: String.self) else {
                return
            }
            
        }],
        
        "issuedTo" : [{ valid, issuedTo in
            
            guard let _ = StandardChecks.checkTypes(valid, path: "issuedTo", value: issuedTo, type: String.self) else {
                return
            }
            
        }]
    ]

    static private func checkTypes<T>(valid: Valid, path: String, value: AnyObject, type: T.Type) -> T? {
        
        if value is T {
            return value as? T
        } else {
            valid.addError("\(path) is not of type \(T.self)")
            return nil
        }
        
    }
}