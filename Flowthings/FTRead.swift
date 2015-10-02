//
//  FTRead.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTRead {
    
    var baseURL : String { get }
    
}

extension FTRead {
    
    public func read(id: String) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        
        return valid.stream  {
            FTAPI.request(.GET, path: self.baseURL + id)
        }
    }
    
}
