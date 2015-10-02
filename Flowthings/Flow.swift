//
//  Flow.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Alamofire

public struct Flow: FTCreate, FTRead, FTFind, FTUpdate, FTDelete {
    
    public var baseURL = "/flow/"
    public var createRequiredParams = ["path"]
    
}

extension Flow {
    
    public func empty(id: String) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        
        return valid.stream {
            FTAPI.request(.DELETE, path: "/drop/\(id)")
        }
    }
    
}