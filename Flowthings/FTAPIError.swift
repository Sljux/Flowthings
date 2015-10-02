//
//  FTAPIError.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public enum FTAPIError : ErrorType {
    
    //Setup
    case URLCanNotBuild(path: String)
    case JSONIsNil
    case HeaderStatusIsMissing
    case UnsupportedMethod(FTMethod)
    case JSONInvalid
 
    //Header Codes
    case BadRequest
    case Unauthorized
    case ServiceUnavailable
    case MessageIdMissing
    
    case MessagesMissing
    case Errors(errors: [String])
    
    //Generic
    case UnexpectedJSONFormat(json: JSON?)
    case BadParams(messages: [String])
    case BaseURLIsNotSet
    
    //Anomalies
    case BodyIsMissing
    case UserCanceled
    case UnknownError
    case ConnectionError(String)
    case ResourseIdMissing
    case SessionIdMissing
    case LocationIsMissing
    case TokenIsMissing
    
    static func errorCodeToString (code: Int) -> String {
    
        switch code {
        
        case -998:
            return	"An unknown error occurred."
        case -999:
            return	"The connection was cancelled."
        case -1000:
            return	"The connection failed due to a malformed URL."
        case -1001:
            return	"The connection timed out."
        case -1002:
            return	"The connection failed due to an unsupported URL scheme."
        case -1003:
            return	"The connection failed because the host could not be found."
        case -1004:
            return	"The connection failed because a connection cannot be made to the host."
        case -1005:
            return	"The connection failed because the network connection was lost."
        case -1006:
            return	"The connection failed because the DNS lookup failed."
        case -1007:
            return	"The HTTP connection failed due to too many redirects."
        case -1008:
            return	"The connection’s resource is unavailable."
        case -1009:
            return	"The connection failed because the device is not connected to the internet."
        case -1010:
            return	"The connection was redirected to a nonexistent location."
        case -1011:
            return	"The connection received an invalid server response."
        case -1012:
            return	"The connection failed because the user cancelled required authentication."
        case -1013:
            return	"The connection failed because authentication is required."
        case -1014:
            return	"The resource retrieved by the connection is zero bytes."
        case -1015:
            return	"The connection cannot decode data encoded with a known content encoding."
        case -1016:
            return	"The connection cannot decode data encoded with an unknown content encoding."
        case -1017:
            return	"The connection cannot parse the server’s response."
        case -1018:
            return	"The connection failed because international roaming is disabled on the device."
        case -1019:
            return	"The connection failed because a call is active."
        case -1020:
            return	"The connection failed because data use is currently not allowed on the device."
        case -1021:
            return	"The connection failed because its request’s body stream was exhausted."
        default:
            return "An unknown connection error occurred code: \(code)"

        }
    
    }
}

