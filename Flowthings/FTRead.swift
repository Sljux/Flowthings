//
//  FTRead.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

import SwiftyJSON

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
    public func read(path
        path: String,
        success: successClosure,
        failure: errorClosure){
            
            FTAPI.request(.GET, path: path,
                success: {
                    json in
                    success(body: json)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
}

