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

public class API {
    
    //Config
    static let domain = "api.flowthings.io"
    static let apiVersion = "v0.1"
    static let secure = true
    
    //Main
    lazy var drop = Drop()
    lazy var flow = Flow()
    
    //Others
    lazy var track = Track()
    lazy var identity = Identity()
    lazy var share = Share()
    lazy var group = Group()
    
    /* Random
    lazy var device = Device()
    lazy var task = Task()
    lazy var mqtt = MQTT()
    lazy var rss = RSS()
    */
    
    //static var req = NSMutableURLRequest()
    static var headers : [String:String] = [:]
    static var creds = Creds()
    
    enum Error : ErrorType {
        case BadPath
        case MissingBody
    }
    
    
    static func url(path: String) -> NSURL? {
        
        guard let accountID = creds.accountID else {
            print("Set creds first")
            return nil
        }
        
        var url = "http"
        if API.secure {
            url += "s"
        }
        
        url += "://" + API.domain + "/"
        url += API.apiVersion + "/" + accountID
        
        //fix helper in case path is not starting with /
        if "/" != path.characters.first! {
            url += "/"
        }
        
        url += path
        
        guard let urlr = NSURL(string: url) else {
            return nil
        }
        
        return urlr
        
    }
    
    public init (creds:Creds) {
        
        API.headers = [
            "X-Auth-Token" : creds.tokenID!,
            "X-Auth-Account" : creds.accountID!,
            "Content-Type" : "application/json"
        ]
        
    }
    
    convenience init(accountID: String, tokenID: String){
        let creds = Creds(accountID: accountID, tokenID: tokenID)
        self.init(creds: creds)
    }
    
    convenience init () {
        let creds = Creds()
        self.init(creds: creds)
    }
    
    static func POST(
        path: String,
        parameters: [String:AnyObject],
        success:(result: Result<AnyObject>) -> ()?,
        failure:(error: ErrorType) -> ()?
        ){
            
            guard let url = API.url(path) else {
                failure(error: API.Error.BadPath)
                return
            }
            
            Alamofire.request(
                .POST,
                url,
                parameters: parameters,
                encoding: .JSON,
                headers: API.headers
                ).responseJSON() {
                    _,_,result in
                    
                    guard result.isSuccess else {
                        
                        print(result.error)
                        print(result.data)
                        
                        failure(error: API.Error.BadPath)
                        return
                    }
                    
                    guard let json_value = result.value else {
                        print("empty value")
                        failure(error: API.Error.BadPath)
                        return
                    }
                    
                    let json = JSON(json_value)
                    
                    if let err = json["head"]["errors"].array?.count {
                        if err > 0 {
                            print("ERROR")
                            print(err, json)
                            failure(error: API.Error.BadPath)
                        }
                    }
                    
                    print("SUCCESS", json)
                    success(result: result)
            }
            
            
    }
    
    static func GET(
        path: String,
        parameters: [String:AnyObject]?,
        success:(body: JSON?) -> ()?,
        failure: (error: Int?) -> ()?
        ){
            
            guard let url = API.url(path) else {
                failure(error: nil)
                return
            }
            
            Alamofire.request(
                .GET,
                url,
                parameters: parameters,
                encoding: .JSON,
                headers: API.headers
                ).responseJSON() {
                    
                    _,_,result in
                    
                    guard result.isSuccess else {
                        
                        print(result.error)
                        print(result.data)
                        
                        failure(error: nil)
                        return
                    }
                    
                    guard let json_value = result.value else {
                        print("empty value")
                        failure(error: nil)
                        return
                    }
                    
                    let json = JSON(json_value)
                    
                    if let err = json["head"]["errors"].array?.count {
                        if err > 0 {
                            print("ERROR")
                            print(err, json)
                            failure(error: nil)
                        }
                    }
                    
                    print("SUCCESS", json)
                    success(body: json)
            }
    }
}