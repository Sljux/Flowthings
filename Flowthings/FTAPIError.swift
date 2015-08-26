//
//  FTAPIError.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftyJSON

public enum FTAPIError : ErrorType {
    
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
    case UnexpectedJSONFormat(json: JSON?)
    case BadParams(messages: [String])
    case BaseURLIsNotSet
    
    //Anomalies
    case BodyIsMissing

    case UserCanceled
    
    case UnknownError
    
}