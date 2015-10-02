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
    
    public func delete(id: String) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        
        return valid.stream  {
            FTAPI.request(.DELETE, path: self.baseURL + id)
        }
        
    }
}
