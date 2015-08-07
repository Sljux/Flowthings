//
//  APIController.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum FTMethod : String {
    case OPTIONS
    case GET
    case HEAD
    case POST
    case PUT
    case PATCH
    case DELETE
    case TRACE
    case CONNECT
}

public class FTAPI {
    
    //Main
    public lazy var drop = Drop()
    lazy var flow = Flow()
    
    //Others
    lazy var track = Track()
    lazy var identity = Identity()
    lazy var share = Share()
    lazy var group = Group()
    
    /* Future
    lazy var device = Device()
    lazy var task = Task()
    lazy var mqtt = MQTT()
    lazy var rss = RSS()
    */
    
    //static var req = NSMutableURLRequest()
    var headers : [String:String] = [:]
    
    init () {
        
        headers = [
            "X-Auth-Token" : Config.tokenID!,
            "X-Auth-Account" : Config.accountID!,
            "Content-Type" : "application/json"
        ]
    }
    
    public convenience init(accountID: String, tokenID: String){
        
        let _ = Config(accountID: accountID, tokenID: tokenID)
        
        self.init()
    }

    public func request(method: FTMethod, path: String, parameters: [String:AnyObject]?,
        success:(body: JSON?) -> (),
        failure: (error: FTAPIError) -> ()
        ) -> Void {
            
            guard let url = Config.url(path) else {
                failure(error: .URLCanNotBuild)
                return
            }
            
            Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: headers).responseJSON(completionHandler: {(req, res, data) in
                switch data {
                case .Success(let json):
                    
                    self.validateResponse(json,
                        success: {
                            json in
                            success(body: json)
                    },
                        failure:{
                            error in
                            failure(error: error)
                    })
                    
                    
                case .Failure(let data, let error):
                    print(req, appendNewline: true)
                    print(res, appendNewline: true)
                    print(data, appendNewline: true)
                    print(error, appendNewline: true)
                }
            })
    }
    
    func validateResponse(
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