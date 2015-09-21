//
//  Flow.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import Alamofire

public struct Flow: FTRead, FTCreate  {
    public var baseURL = "/flow/"
}

/** Drop Specific Methods */
extension Flow {
    
    
    /**
    
    flowthings.io api.<service>.create method
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format, has to have valid path and elems
    
    path
    
    The path member can be a string of up to 128 characters. The path is always referenced by a / and an account id, and at least one other identifier, with each identifier is seperated by a /
    
    Optional Fields
    
    capactiy
    
    The maximum number of Drops stored within the Flow. The default value is 1,000, maximum is 100,000. A value of 0 will store no data. When the Flow exceeds its capacity of Drops, older Drops will be deleted automatically.
    
    
    description
    
    A more detailed description of the Flow.
    
    
    filter
    
    A filter which is used as a pass/fail test for writing new Drops to the Flow. See Flow Filter Language for more information.

    
    - returns: FTStream
    */
    public func create(params params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["path"], params: params)
        
        return valid.stream  {
            FTAPI.request(.POST, path: self.baseURL, params: params)
        }
        
    }
    
    /**
    flowthings.io api.<service>.delete method
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format
    
    - returns: FTStream
    */
    public func delete(flowID flowID: String) -> FTStream {
        
        let valid = Valid(checkFor: ["flow_id":flowID])
        
        let path = self.baseURL + flowID
        
        return valid.stream  {
            FTAPI.request(.DELETE, path: path)
        }
        
    }
    
}