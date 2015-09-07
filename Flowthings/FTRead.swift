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
    
    /** 
        FTRead is Protocol func extension bringing in read 
    
        - parameter path:    url (String)
    
        - returns: FTStream
    */
    public func read(path path: String) -> FTStream {
        
        let valid = Valid(checkFor: ["path":path])
        
        return valid.stream  {
            FTAPI.request(.GET, path: path)
        }
    }
    
}

