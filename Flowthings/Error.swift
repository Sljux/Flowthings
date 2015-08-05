//
//  Error.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

enum FlowThingsError {
    case BadRequest
    case Forbidden
    case NotFound
    case ServerError
    case Error (Creds, Int, [String])
    /*
    The special-cased FlowThingsError have the following properties:
    
    creds = Creds()
    //The credentials used to make the request
    
    status : Int?
    //The status code of the response
    
    errors : [String]?
    //The error array returned by the platform
    */
}
