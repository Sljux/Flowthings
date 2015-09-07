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
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format
    
    */
    public func create(params params: ValidParams) -> FTStream {
        
        
        let checks = Checks()
        
        let valid = Valid(checks: checks, params: params)
        
        if valid.isValid  {
            return FTAPI.request(.POST, path: baseURL, params: params)
        }
        
        return FTStream { _, _, reject, _ in
            reject(.BadParams(messages: valid.messages)) }
        
    }
    
}