//
//  FTFind.swift
//  Flowthings
//
//  Created by Ceco on 30/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTFind {
    
    var baseURL : String { get }
    
}

extension FTFind {
    
    public func find(params: ValidParams) -> FTStream {
        return FTAPI.request(.GET, path: self.baseURL, params: params)
    }
    
}
