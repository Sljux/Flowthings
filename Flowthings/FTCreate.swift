//
//  FTCreate.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftyJSON

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
    
    #### Example usage:
    
    ```swift
    let params : ValidParams = [
        "path" : "/account/some/path",
        "elems":[
            "task":"task name",
            "description": "Some Description"
        ]
    ]
    
    api.drop.create(
        params: params,
        success:{
        json in
        print("success")
    },
        failure:{
        error in
        print(error)
    })
    ```
    
    */
    public func create(
        params params: ValidParams,
        success: successClosure,
        failure: errorClosure)  {
            
            let checks = Checks(param: "path",
                test: {
                    valid, path in
                    
                    guard let p = path as? CheckString else {
                        valid.addError("param: 'path' is not a String")
                        return
                    }
                    
                    if p.isShorterThen(3){
                        valid.addError("path: \"" + p + "\" is too short")
                        return
                    }
            })
            
            let extra_test : ValidTest = {
                valid, elems in
                
                guard let e = elems as? ValidParams else {
                    valid.addError("elems are not of time FlowParams alias: [String:AnyObject]")
                    return
                }
                
                
                let _ = JSON(e)
                
                //                //FAIL Example:
                //                guard let _ = json["test"]["id"].string else {
                //                    valid.addMessage("elems[\"test\"][\"id\"] is not provided")
                //                    valid.isValid = false
                //                    return
                //                }
            }
            
            checks.add("elems", test: extra_test)
            
            let check = Valid(checks: checks, params: params)
            
            guard check.isValid else {
                failure(error: .BadParams(messages: check.messages))
                return
            }
            
            guard !baseURL.isEmpty else {
                failure(error: .BaseURLIsNotSet)
                return
            }
            
            FTAPI.request(.POST,
                path: baseURL,
                params: params,
                success: {
                    json in
                    success(body: json)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
}