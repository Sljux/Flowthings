//
//  Identity.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftyJSON


struct Identity {
    var baseURL : String { return "/identity/" }
    
    func read(
        identityID: String,
        success: (body: JSON)->(),
        failure: (error: FTAPIError)->()){
            
        let path = baseURL + identityID
            
            FTAPI.request(.GET, path: path)
    }
    
    //func find(){}
    //func update(){}
}