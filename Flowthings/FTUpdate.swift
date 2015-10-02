//
//  FTUpdate.swift
//  Flowthings
//
//  Created by Ceco on 30/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTUpdate {
    
    var baseURL : String { get }
    
}

extension FTUpdate {

    public func update(id: String, params: ValidParams) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        
        let path = self.baseURL + id
        
        return valid.stream  {
            FTAPI.request(.PUT, path: path, params: params)
        }
    }
    
}
