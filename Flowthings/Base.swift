//
//  Base.swift
//  Flowthings
//
//  Created by Ceco on 8/8/15.
//  Copyright © 2015 cityos. All rights reserved.
//

//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import Alamofire



public class Base : ValidChecksProtocol {
    
    ///Last part of API URL on https://domain.io/vX.X</.../> e.g. /drop/
    var baseURL : String { return "/base/" }
    
    ///Checks for validations of incoming params
    public var checks : ValidChecks = ValidChecks()
    
    init(){}
    
    
    
    /**
    
    General flowthings.io api.service.create method
    
    - Parameter params:     ValidParams [String:AnyObject] type for eazy work with JSON
    
    - Parameter success:     Closure that will recive json (type JSON) on success
    
    - Parameter failure:     Closure that will recive error (type FTAPIError) on failure
    
    - Precondition:
    api has to be initialized
    ```swift
    
    let api = FlowthingsAPI(
        accountID: "XXX",
        tokenID: "XXX"
    )
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
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
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
//                
//                //PASS Example:
//                guard let _ = json["description"].string else {
//                    valid.addMessage("\"elems\": [\"description\"] is not provided")
//                    valid.isValid = false
//                    return
//                }
//                
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
                failure(error: .badParams(check.messages))
                return
            }
            
            let path = baseURL
            
            FTAPI.request(.POST, path: path, params: params,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    public func read(
        path: String,
        success: (body: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.GET, path: path,
                success: {
                    json in
                    success(body: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    func find(
        params: ValidParams,
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            let path = baseURL
            
            FTAPI.request(.GET, path: path, params: params,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
            
    }
    
    func multiFind(
        model model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            let path = baseURL
            
            FTAPI.request(.GET, path: path, params: model,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    func update(
        path: String,
        model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.PUT, path: path, params: model,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    func memberUpdate(
        path: String,
        params: ValidParams,
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.PUT, path: path, params: params,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    func delete(
        path: String,
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.DELETE, path: path, params: nil,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
}