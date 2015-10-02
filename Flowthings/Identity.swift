//
//  Identity.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Identity : FTRead, FTFind, FTUpdate {
    
    public var baseURL = "/identity/"
    
}

extension Identity {
    
    public func read() -> FTStream {
        return FTAPI.request(.GET, path: self.baseURL)
    }
    
}