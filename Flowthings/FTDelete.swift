//
//  FTDelete.swift
//  Flowthings
//
//  Created by Ceco on 9/16/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTDelete {
    
    var baseURL : String { get }
}

extension FTDelete {
    
    /**
    
    flowthings.io api.<service>.delete method
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format
    
    - returns: FTStream
    */
    public func delete(params params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["path", "elems"], params: params)
        
        return valid.stream  {
            FTAPI.request(.DELETE, path: self.baseURL, params: params)
        }
        
    }
}
