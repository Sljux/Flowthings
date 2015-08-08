//
//  FTAPIError.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftyJSON

public enum FTAPIError {
    
    //Setup
    case URLCanNotBuild(path: String)
    case JSONIsNil
    case HeaderStatusIsMissing
    case UnsupportedMethod(FTMethod)
    
    //Header Codes
    case BadRequest
    case Unauthorized
    case ServiceUnavailable
    
    case MessagesMissing
    case Errors(errors: [JSON])
    
    //Generic
    case UnexpectedJSONFormat(JSON?)
    
    //Anomalies
    case BodyIsMissing
    
    //Drop
    case MissingPath
    
}

