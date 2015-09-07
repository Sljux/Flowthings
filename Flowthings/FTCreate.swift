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
    
    flowthings.io api.<service>.create method
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format
    
    - returns: FTStream
    */
    public func create(params params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["path", "elems"], params: params)
        
        return valid.stream  {
            FTAPI.request(.POST, path: self.baseURL, params: params)
        }
        
    }
    
}