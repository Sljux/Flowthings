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
    case URLCanNotBuild
    case JSONIsNil
    case HeaderStatusIsMissing
    
    //Header Codes
    case BadRequest
    case Unauthorized
    case ServiceUnavailable
    
    case MessagesMissing
    case Errors(errors: [JSON])
    
    //Anomalies
    case BodyIsMissing

}

