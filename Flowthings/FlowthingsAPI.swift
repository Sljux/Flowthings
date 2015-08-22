//
//  APIController.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum FTMethod : String {
    case GET, POST, PUT, DELETE
    
    //case OPTIONS, HEAD, PUT, PATCH, DELETE, TRACE, CONNECT
}

typealias FTAPI = FlowthingsAPI

public class FlowthingsAPI {
    
    public lazy var drop = Drop()
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
    
    public static func request(
        ftmethod: FTMethod,
        path: String,
        params: ValidParams? = nil,
        success:(body: JSON?) -> (),
        failure: (error: FTAPIError) -> ()
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
        success:(json: JSON) -> (),
        failure:(error: FTAPIError) -> ()
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
                success(json: data)
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
            
            success(json: data)
    }
}