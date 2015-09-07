//
//  FTAPI.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Alamofire
import SwiftTask

public enum FTMethod : String {
    case GET, POST, PUT, DELETE
    //Headers not supported yet
    //case OPTIONS, HEAD, PATCH, TRACE, CONNECT
}


public typealias Progress = (
    bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64)

public typealias Value = JSON
public typealias Error = FTAPIError

public enum FTResult {
    case Success(Value)
    case Failure(Error)
}

public typealias FTStream = Task<Progress, Value, Error>

public class FTAPI {
    
    public lazy var drop = Drop()
    public lazy var flow = Flow()
    
    lazy var track = Track()
    lazy var identity = Identity()
    lazy var share = Share()
    lazy var group = Group()
//    lazy var device = Device()
//    lazy var task = Task()
//    lazy var mqtt = MQTT()
//    lazy var rss = RSS()
    
    lazy var valid = Valid()
    
    static var headers : [String:String] = [:]
    
    public init(){
        let _ = Config()
        setAuth ()
    }
    
    public init(accountID: String, tokenID: String){
        
        let _ = Config(accountID: accountID, tokenID: tokenID)
        setAuth ()
    }
    
    func setAuth () {
        
        FTAPI.headers = [
            "X-Auth-Token" : Config.tokenID!,
            "X-Auth-Account" : Config.accountID!,
            "Content-Type" : "application/json"
        ]
        
    }
    
    public static func request(
        ftmethod: FTMethod,
        path: String,
        params: ValidParams? = nil
        ) -> FTStream {
            
            //Setting up the task
            let stream = FTStream { progress, fulfill, reject, configure in
                
                
                //removing dependecy on Alamofire u apps
                var method : Alamofire.Method
                var encoding : ParameterEncoding = .JSON
                
                switch ftmethod {
                    
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
                
                
                guard let url = Config.url(path) as? URLStringConvertible else {
                    reject(.URLCanNotBuild(path: path))
                    return
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
                
                response.progress {
                    (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                    
                    progress((bytesWritten,
                            totalBytesWritten,
                            totalBytesExpectedToWrite))
                }
                response.responseJSON(completionHandler: {
                    (req, res, data) in
//                    print(data)
                    switch data {
                    case .Success(let json):
                        
                        let result: FTResult = FTAPI.validateJSON(json)
                        
                        switch result {
                        case .Success(let json):
                                fulfill(json)
                        case .Failure(let error):
                                reject(error)
                        }
                        
                    case .Failure( _, let error):
                        //print(error._code)
                        
                        if let code = error._code as Int? {
                            
                            let message = FTAPIError.errorCodeToString(code)
                            reject(FTAPIError.connectionError(message))
                        }
                        //TODO: Add better handling here
                        reject(.BadRequest)
                    }
                    })
            }
            return stream
    }

    public static func validateJSON(jsonString: AnyObject?)
        -> FTResult {
            
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
            
            switch statusCode {
                
            case 400 :
                return .Failure(.BadRequest)
            case 401 :
                return .Failure(.Unauthorized)
            case 503 :
                return .Failure(.ServiceUnavailable)
            default:
                break
                
            }
            
            if let errors = data["head"]["errors"].array as? [String] {
                
                if errors.count > 0 {
                    return .Failure(.Errors(errors: errors))
                }
            }
            
            guard let _ = data["body"].array else {
                return .Failure(.BodyIsMissing)
            }
            return .Success(data)
    }
}