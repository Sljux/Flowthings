//
//  WSS.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import SwiftWebSocket

public class WSS : WebSocket {
    
    //Config
    static let wsSessionIDURL = "https://ws.flowthings.io/session"
    static let wsSessionURLBase = "wss://ws.flowthings.io/session"

    var id : String?
    var webSocket : WebSocket?
    
    enum SessionError: ErrorType {
        case CanNotGetSessionKey
    }
    
//    init(creds: Creds)  {
//
//        let url = NSURL(string: WSS.wsSessionIDURL)!
//        
//        let req = NSMutableURLRequest(URL: url)
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.setValue(creds.accountID, forHTTPHeaderField: "X-Auth-Account")
//        req.setValue(creds.tokenID, forHTTPHeaderField: "X-Auth-Token")
//        req.HTTPMethod = "POST"
//
//    }
    
//    func fetchSessionID(req: NSMutableURLRequest){
//    
//        Alamofire.request(req).responseJSON() {
//            request,response,data,error in
//            if error == nil {
//                let json = JSON(data!)
//                
//                if let sessID = json["body"]["id"].string {
//                    self.id = sessID
//                    //super.init(WSS.wsSessionURLBase + "/" + sessID + "/ws")
//                    return
//                }
//                print("Could Not connect to Web Socket")
//                return
//            } else {
//                if let message = error?.description{
//                    print(message)
//                }
//                else{
//                    print("Could Not connect to Web Socket ")
//                }
//                return
//            }
//            
//        }
//    }

    func sendFromDictionary(message: [String:String]){
        //let jsonMessage = JSON(message)
        //self.webSocket!.send(jsonMessage)
        
    }

//    func wssEchoTest(){
//        
//        var message : [String:String] = [:]
//        
//        message["msgId"] = "msgId"
//        message["object"] = "flow"
//        message["type"] = "find"
//        message["id"] = "f55ae03e95bb7097a936ac6cb"
//        
//        let creds = Creds()
//        
//        let ws = WSS(creds: creds)
//        
//        let send : ()->() = {
//            ws.sendFromDictionary(message)
//        }
//        
//        ws.webSocket!.event.open = {
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
}
