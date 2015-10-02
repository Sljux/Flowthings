//
//  FTCreate.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTCreate {
    
    var baseURL : String { get }
    var createRequiredParams : [String] { get }
    
}

extension FTCreate {
    
    public func create(params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: createRequiredParams, params: params)
        
        return valid.stream  {
            FTAPI.request(.POST, path: self.baseURL, params: params)
        }
        
    }
}