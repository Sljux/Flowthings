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
import Alamofire

public struct Base : ValidChecksProtocol, FTRead, FTCreate {
    
    
    public var baseURL : String
    
    /**
    Init with last part of API URL that comes after https://domain.io/vX.X 
    e.g. let base = Base("/drop/")
    
    - parameter baseURL: Last part of API URL on https://domain.io/vX.X</.../> e.g. /drop/
    
    - returns: Base struct
    */
    init(baseURL : String){
        self.baseURL = baseURL
    }
    
    ///Checks for validations of incoming params
    public var checks : ValidChecks = ValidChecks()

    /**
    Base Read method
    
    - Parameter path   :  flow path
    - Parameter success:  
    - Parameter failure:  <#failure description#>
    */

    
    func find(
        params: ValidParams,
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            guard !baseURL.isEmpty else {
                failure(error: .BaseURLIsNotSet)
                return
            }
            
            FTAPI.request(.GET, path: baseURL, params: params)
            
    }
    
    func multiFind(
        params params: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            guard !baseURL.isEmpty else {
                failure(error: .BaseURLIsNotSet)
                return
            }
            
            FTAPI.request(.GET, path: baseURL, params: params)
    }
    
    func update(path: String, params: ValidParams){
            FTAPI.request(.PUT, path: path, params: params)
    }
    
    func memberUpdate(path: String, params: ValidParams){
            
            FTAPI.request(.PUT, path: path, params: params)
    }
    
    func delete(
        path: String,
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.DELETE, path: path)
    }
    
}