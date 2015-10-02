//
//  FTAPI.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Alamofire
import SwiftWebSocket
import PromiseKit

public enum FTMethod : String {
    case GET, POST, PUT, DELETE
    //Headers not supported yet
    //case OPTIONS, HEAD, PATCH, TRACE, CONNECT
}

public typealias Value = JSON
public typealias Error = FTAPIError

public typealias FTStream = Promise<JSON>

public enum FTResult {
    case Success(Value)
    case Failure(Error)
}

public enum FTWSResult {
    case PushSuccess(msgId: String, data: Value)
    case MessageSuccess(msgId: String, data: Value)
    case MessageFailure(msgId: String, errorMessages: [String])
    case Failure(Error)
}

public enum URLType : String {
    case API = "api"
    case WS = "ws"
}

public class FTAPI {
    
    public lazy var drop = Drop()
    public lazy var flow = Flow()
    public lazy var ws = WSConnection()
    public lazy var track = Track()
    public lazy var identity = Identity()
    public lazy var share = Share()
    public lazy var token = Token()
    public lazy var mqtt = MQTT()
    public lazy var group = Group()
	public lazy var device = Device()
	public lazy var apiTask = ApiTask()
	public lazy var rss = RSS()
    
    static var headers : [String:String] = [:]
    
    public init() {
        let _ = Config()
        setAuth()
    }
    
    public init(accountID: String, tokenID: String) {
        let _ = Config(accountID: accountID, tokenID: tokenID)
        setAuth()
    }
    
    func setAuth() {
        
        FTAPI.headers = [
            "X-Auth-Token" : Config.tokenID!,
            "X-Auth-Account" : Config.accountID!,
            "Content-Type" : "application/json"
        ]
        
    }
    
    public static func request(ftMethod: FTMethod, path: String, params: ValidParams? = nil, type: URLType = .API) -> FTStream {
            
        return FTStream { fulfill, reject in
                
            //removing dependecy on Alamofire in apps
            var method : Alamofire.Method
            var encoding : ParameterEncoding = .JSON
            
            switch ftMethod {
                    
            case .GET :
                method = Alamofire.Method.GET
                encoding = .URL
            case .POST :
                method = Alamofire.Method.POST
            case .PUT :
                method = Alamofire.Method.PUT
            case .DELETE :
                method = Alamofire.Method.DELETE
                
            }
                
            guard let url = Config.url(path, type: type) as? URLStringConvertible else {
                return reject(Error.URLCanNotBuild(path: path))
            }
                
            var response : Alamofire.Request
                
            if let _ = params {
                response = Alamofire.request(
                    method,
                    url,
                    parameters: params,
                    encoding: encoding,
                    headers: FTAPI.headers)
            } else {
                response = Alamofire.request(
                    method,
                    url,
                    headers: FTAPI.headers)
            }
                
            response.responseJSON { req, res, data in
                    
                switch data {
                case .Success(let json):
                    
                    let result: FTResult = FTAPI.validateJSONforAPI(json)
                    
                    switch result {
                    case .Success(let json):
                        fulfill(json)
                    case .Failure(let error):
                        reject(error)
                    }
                        
                case .Failure( _, let error):
                    if let code = error._code as Int? {
                        let message = Error.errorCodeToString(code)
                        reject(Error.ConnectionError(message))
                    }
                    //TODO: Add better handling here
                    reject(Error.BadRequest)
                }
            }
        }
    }
    
    public static func validateJSONforWS(jsonString: String?) -> FTWSResult {
        
        guard let json = jsonString else {
            return .Failure(.JSONIsNil)
        }
        
        guard let data = try? JSON(string: json) else {
            return .Failure(.JSONInvalid)
        }
        
        if data.type == .Null {
            return .Failure(.JSONIsNil)
        }
        
        if let type = data["type"].string, flowId = data["resource"].string where type == "message" {
            let value = data["value"]
            return .PushSuccess(msgId: flowId, data: value)
        }
        
        guard let ok = data["head"]["ok"].bool else {
            return .Failure(.HeaderStatusIsMissing)
        }
        
        guard let msgId = data["head"]["msgId"].string else {
            return .Failure(.MessageIdMissing)
        }
        
        if ok {
            return .MessageSuccess(msgId: msgId, data: data)
        } else {
            let errors : [String] = data["head"]["errors"].array as? [String] ?? []
            return .MessageFailure(msgId: msgId, errorMessages: errors)
        }
    }

    public static func validateJSONforAPI(jsonString: AnyObject?) -> FTResult {
        
        guard let json = jsonString else {
            return .Failure(.JSONIsNil)
        }
        
        let data = JSON(json)
        
        guard (data.type != .Null) else {
            return .Failure(.JSONIsNil)
        }
        
        guard let ok = data["head"]["ok"].bool else {
            return .Failure(.HeaderStatusIsMissing)
        }
        
        if ok == true {
            return .Success(data)
    	}
        
        guard let statusCode = data["head"]["status"].int else {
            return .Failure(.HeaderStatusIsMissing)
        }
        
        if let errors = data["head"]["errors"].array as? [String] {
            if errors.count > 0 {
                return .Failure(.Errors(errors: errors))
            }
        }
        
        switch statusCode {
            
        case 200 :
            return .Success(data)
        case 400 :
            return .Failure(.BadRequest)
        case 401 :
            return .Failure(.Unauthorized)
        case 503 :
            return .Failure(.ServiceUnavailable)
        default:
            break
                
        }
        
        guard let _ = data["body"].array else {
            return .Failure(.BodyIsMissing)
        }
        
        return .Success(data)
    }
}