//
//  Flowthings.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/23/15.
//  Copyright © 2015 cityos. All rights reserved.
//


////OLD - remove later
//
//import Foundation
//import Alamofire
//import SwiftyJSON
//import SwiftWebSocket
//
//
//public class Flowthings {
//    
//    var req = NSMutableURLRequest()
//    var creds = Creds()
//    
//    static let urlBase = "https://api.flowthings.io"
//    static let apiVersion = "v0.1"
//    
//    init () {
//        
//        let creds = Creds()
//        req.setValue(creds.tokenID, forHTTPHeaderField: "X-Auth-Token")
//        req.setValue(creds.accountID, forHTTPHeaderField: "X-Auth-Account")
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.HTTPMethod = "GET"
//    
//    }
//
//    init (creds:Creds) {
//        
//        req.setValue(creds.tokenID, forHTTPHeaderField: "X-Auth-Token")
//        req.setValue(creds.accountID, forHTTPHeaderField: "X-Auth-Account")
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.HTTPMethod = "GET"
//        
//    }
//
//    func POST(urlString: String, success:(body: JSON?) -> (), failure:(message: String?) -> ()){
//
//        guard let url = NSURL(string: urlString) else {
//            failure(message: "Bad path")
//            return
//        }
//        
//        req.URL = url
//        req.HTTPMethod = "POST"
//        
//        Alamofire.request(req).responseJSON() {
//            request,response,data,error in
//            if error == nil {
//                let json = JSON(data!)
//                
//                success(body: json)
//                
//            } else {
//                failure(message: "Bad Request")
//            }
//        }
//        
//
//    }
//    
//    func GET(path: String, success:(body: JSON?) -> (), failure:(message: String?) -> ()){
//
//        req.HTTPMethod = "GET"
//        
//        guard let url = getFullUrl(path) else {
//            failure(message: "Bad Path" + path)
//            return
//        }
//        
//        req.URL = url
//        Alamofire.request(self.req).responseJSON() {
//            request,response,data,error in
//            if error == nil {
//                var json = JSON(data!)
//                
//                if let _ = json["body"].array {
//                    success(body: json["body"])
//                }
//                else{
//                    failure(message: "Missing Body")
//                }
//            } else {
//                failure(message: "Bad request")
//            }
//        }
//    }
//    
//    func getFullUrl(path: String) -> NSURL? {
//    
//        if path.isEmpty {
//            print("empty path")
//            return nil
//        }
//        
//        var urlString = Flowthings.urlBase + "/" + Flowthings.apiVersion
//        
//        //In case path is not starting with / - fix
//        if "/" != path.characters.first! {
//            urlString += "/"
//        }
//        
//        urlString += path
//        
//        guard let url = NSURL(string: urlString) else {
//            return nil
//        }
//        
//        return url
//        
//    }
//    
//    func dropsExample(flow: Flow){
//        
//        guard let url = flow.path else {
//            print ("Bad path")
//            return
//        }
//        
//        self.GET(url,
//            success: {
//            body in
//        
//            if let drops = body!.array {
//
//                var parsedDrops: [Drop] = []
//                
//                for drop in drops {
//                    
//                    if let parsedDrop = Drop.jsonToDrop(drop) {
//                        
//                        parsedDrops.append(parsedDrop)
//                    }
//                    
//                }
//                //print(parsedDrops)
//            }
//        
//            },
//            failure: {
//                message in
//    
//                print(message)
//            }
//        )
//    }
//
////    class func getLightsSensorData(sensor: String, completion:(dataPoints: [Double]?) -> ()) {
////        
////        let flow_id = "f55ae03e95bb7097a936ac6cb"
////        let url = NSURL(string: "https://api.flowthings.io/v0.1/ceco/drop/\(flow_id)?limit=50")!
////        
////        
////        Alamofire.request(self.req).responseJSON() {
////            request,response,data,error in
////            if error == nil {
////                var json = JSON(data!)
////                var dataPoints = [Double]()
////                
////                for one in json["body"].arrayValue {
////                    
////                    if let sensorData = one["elems"][sensor]["value"].double {
////                        dataPoints.append(sensorData)
////                    }
////                    
////                }
////                completion(dataPoints: dataPoints)
////            } else {
////                completion(dataPoints: nil)
////            }
////        }
////        
////    }
//    
//    
//    class func wssEchoTest(){
//        
//        var message : [String:String] = [:]
//        
//        message["msgId"] = "msgId"
//        message["object"] = "flow"
//        message["type"] = "find"
//        message["id"] = "f55ae03e95bb7097a936ac6cb"
//        
//        Session.setWebSocket()
//        
//        let ws = Session.webSocket!
//        
//        let send : ()->() = {
//            let jsonMessage = JSON(message)
//            //print("send: \(jsonMessage)")
//            ws.send(jsonMessage)
//        }
//        
//        ws.event.open = {
//            print("opened")
//            send()
//        }
//        
//        ws.event.close = { code, reason, clean in
//            print("close")
//        }
//        
//        ws.event.error = { error in
//            print("error \(error)")
//        }
//        
//        ws.event.message = { message in
//            if let jsonString = message as? String {
//                if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
//                    let json = JSON(data: dataFromString)
//                    
//                    for (index: key, subJson: JSON) in json["body"] {
//                        print(key,JSON)
//                    }
//                    //print(json)
//                }
//            }
//            
//        }
//        
//        ws.close()
//    }
//
//}