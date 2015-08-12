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
    
    var baseURL : String { return "/base/" }
    
    var checks : ValidChecks = ValidChecks()
    
    init(){}
    
    public func create(
        params params: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            let required = ["elems", "path"]
            
            var checks = Checks()
            
            let tests : ValidTests = [{
                valid, path in
                if path.isEmail(){
                    valid.addMessage("\"" + path + "\" is not valid email")
                    valid.isValid = false
                }
                if path.isShorterThen(100){
                    valid.addMessage("\"" + path + "\" is too short")
                    valid.isValid = false
                }                
            }]
            
            let index : String = "path"
            checks.run[index] = ValidTests()
            checks.run[index]? = tests
            
            let check = Valid(checks: checks, params: params, checkFor: required)
            
//                    let params = [
//            "flow_id" : "123",
//            "drop_id" : "123"
//        ]
//        
//        let checks = [
//            "flow_id",
//            "drop_id"
//        ]
//        
//        let valid = Valid(params: params, checkFor: checks)
//        
//        print(valid.tests)
//        
//        if(valid.isValid){
//            print("All good")
//        }
//        else{
//            print(valid.getMessages())
//        }
            
            guard check.isValid else {
                failure(error: .badParams(check.messages))
                return
            }
            
            let path = baseURL
            
            FTAPI.request(.POST, path: path, parameters: params,
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
        model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            let path = baseURL
            
            FTAPI.request(.GET, path: path, parameters: model,
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
            
            FTAPI.request(.GET, path: path, parameters: model,
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
            
            FTAPI.request(.PUT, path: path, parameters: model,
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
        model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.PUT, path: path, parameters: model,
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
            
            FTAPI.request(.DELETE, path: path, parameters: nil,
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