//
//  FTCreate.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTCreate {
    
    var baseURL : String { get }
}

extension FTCreate {
    
    
    /**
    
    General flowthings.io api.service.create method
    
    - parameter params:     ValidParams [String:AnyObject] type for eazy work with JSON
    - parameter success:     Closure that will recive json (type JSON) on success
    - parameter failure:     Closure that will recive error (type FTAPIError) on failure
    ```
    
    */
    public func create(params params: ValidParams)  -> FTStream {
        
        let checks = Checks(param: "path",
            test: {
                valid, path in
                
                guard let p = path as? CheckString else {
                    return valid.addError("param: 'path' is not a String")
                }
                
                if p.isShorterThen(3){
                    return valid.addError("path: \"" + p + "\" is too short")
                }
        })
        
        let extra_test : ValidTest = {
            valid, elems in
            
            guard let e = elems as? ValidParams else {
                return valid.addError("elems are not of time FlowParams alias: [String:AnyObject]")
            }
            
            
            let json = JSON(e)
            
            //FAIL Example:
            guard json.count > 0 else {
                return valid.addError("Sending empty elems")
            }
        }
        
        checks.add("elems", test: extra_test)
        
        let check = Valid(checks: checks, params: params)
                
        if check.isValid  {
            return FTAPI.request(.POST, path: baseURL, params: params)
        }
        
        let stream = FTStream {
            progress, fulfill, reject, configure in
            
            reject(.BadParams(messages: check.messages))
            
        }
        
        return stream
        
        
    }
    
}