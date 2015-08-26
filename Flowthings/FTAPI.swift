//
//  APIController.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SwiftTask

public enum FTMethod : String {
    case GET, POST, PUT, DELETE
    //Headers not supported yet
    //case OPTIONS, HEAD, PATCH, TRACE, CONNECT
}

public typealias successClosure = (body: JSON) -> ()
public typealias errorClosure = (error: FTAPIError) -> ()

public typealias Progress = (
    bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64)

public typealias Value = JSON?
public typealias Error = NSError

typealias AlamofireTask = Task<Progress, Value, Error>
//public typealias ErrorInfo = (error: Error?, isCancelled: Bool)

let myError = NSError(domain: "MyErrorDomain", code: 0, userInfo: nil)

//
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class FTAPI {
    
    public var drop = Drop()
    lazy var flow = Flow()
    
    //Others
    lazy var track = Track()
    lazy var identity = Identity()
    lazy var share = Share()
    lazy var group = Group()
    
    lazy var valid = Valid()
    
    /* Future
    lazy var device = Device()
    lazy var task = Task()
    lazy var mqtt = MQTT()
    lazy var rss = RSS()
    */
    
    //static var req = NSMutableURLRequest()
    static var headers : [String:String] = [:]
    
    init () {
        
        FTAPI.headers = [
            "X-Auth-Token" : Config.tokenID!,
            "X-Auth-Account" : Config.accountID!,
            "Content-Type" : "application/json"
        ]
        
    }
    
    public convenience init(accountID: String, tokenID: String){
        
        let _ = Config(accountID: accountID, tokenID: tokenID)
        
        self.init()
    }
    
    public static func request(ftmethod: FTMethod,
        path: String,
        params: ValidParams? = nil,
        success: successClosure,
        failure: errorClosure
        ) -> Void {
            
            
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
                failure(error: .URLCanNotBuild(path: path))
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
            
            response.responseJSON(completionHandler: {(req, res, data) in
                switch data {
                case .Success(let json):
                    
                    FTAPI.validateResponse(json,
                        success: {
                            json in
                            success(body: json)
                        },
                        failure:{
                            error in
                            failure(error: error)
                    })
                    
                    
                case .Failure(let data, let error):
                    print(req)
                    print(res)
                    print(data)
                    print(error)
                    
                    failure(error: FTAPIError.BadRequest)
                }
            })
    }
    
    static func validateResponse(
        json_optional: AnyObject?,
        success:successClosure,
        failure:errorClosure
        ) {
            
            guard let json = json_optional else {
                failure(error: .JSONIsNil)
                return
            }
            
            let data = JSON(json)
            
            guard (data != nil) else {
                failure(error: .JSONIsNil)
                return
            }
            
            guard let ok = data["head"]["ok"].bool else {
                
                failure(error: .HeaderStatusIsMissing)
                return
            }
            
            if ok == true {
                success(body: data)
                return
            }
            
            
            guard let statusCode = data["head"]["status"].int else {
                
                failure(error: .HeaderStatusIsMissing)
                return
            }
            
            switch statusCode {
                
            case 400 :
                failure(error: .BadRequest)
                return
            case 401 :
                failure(error: .Unauthorized)
                return
            case 503 :
                failure(error: .ServiceUnavailable)
                return
            default:
                break
                
            }
            
            if let errors = data["head"]["errors"].array {
                
                if errors.count > 0 {
                    
                    failure(error: .Errors(errors: errors))
                    
                    return
                }
            }
            
            guard let _ = data["body"].array else {
                
                failure(error: .BodyIsMissing)
                return
            }
            
            success(body: data)
    }
}