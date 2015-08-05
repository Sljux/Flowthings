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
    
    static var req = NSMutableURLRequest()
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
        
        API.req.setValue(creds.tokenID!, forHTTPHeaderField: "X-Auth-Token")
        API.req.setValue(creds.accountID!, forHTTPHeaderField: "X-Auth-Account")
        API.req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let manager = Manager.sharedInstance
//        
//        // Specifying the Headers we need
//        manager.session.configuration.HTTPAdditionalHeaders = [
//            "X-Auth-Token": creds.tokenID!,
//            "X-Auth-Account": creds.accountID!,
//            "Content-Type": "application/json"
//        ]
    }

    convenience init(accountID: String, tokenID: String){
        let creds = Creds(accountID: accountID, tokenID: tokenID)
        self.init(creds: creds)
    }

    convenience init () {
        let creds = Creds()
        self.init(creds: creds)
    }
    
    static func POST(path: String, parameters: [String:AnyObject], success:(body: JSON?) -> (), failure:(error: ErrorType) -> ()){
        
        
        API.req.URL = API.url(path)
        API.req.HTTPMethod = "POST"

        do {
            try API.req.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions(rawValue: 0))

        
            //try API.req.HTTPBody = JSON(parameters).rawData()
        }
        catch {
            //handle bad parsing
        }
        
        
        
        Alamofire.request(API.req).responseJSON() {
            _,_,json,error in
            
            if let err = error {
                print("ERROR")
                print(err)
                failure(error: err)
                return
            }
            
            let json = JSON(json!)
            
            if let err = json["head"]["errors"].array {
                print("ERROR")
                print(err, json)
                return
            }
            
            print("SUCCESS", json)
            success(body: json)
        }
        
        
    }

    func GET(path: String, success:(body: JSON?) -> ()?, failure:(error: ErrorType?) -> ()?){
        
        API.req.HTTPMethod = "GET"
        
        guard let url = API.url(path) else {
            failure(error: API.Error.BadPath)
            return
        }
        
        API.req.URL = url
        Alamofire.request(API.req).responseJSON() {
            _,_,data,error in
            if error == nil {
                var json = JSON(data!)
                
                if let _ = json["body"].array {
                    success(body: json["body"])
                }
                else{
                    failure(error: Error.MissingBody)
                }
            } else {
                failure(error: error)
            }
        }
    }
    
}