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
    FTRead is Protocol func extension
    
    - parameter path:    url (String)
    - parameter success: Closure type: (body: JSON) -> ()
    - parameter failure: Closure type: (error: FTAPIError) -> ()
    */
    public func read(path path: String) -> FTStream {
            
            return FTAPI.request(.GET, path: path)
    }
    
}

