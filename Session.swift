//
//  Session.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/24/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftWebSocket

class Session {

    static var id : String?
    static var webSocket : WebSocket?
    
    static let wsSessionIDURL = "https://ws.flowthings.io/session"
    static let wsSessionURLBase = "wss://ws.flowthings.io/session"
    
    enum SessionError: ErrorType {
        case CanNotGetSessionKey
    }

    class func setSessionID(completion:(sessionID: String?) -> ())  {
        
        //Once set no need to do it again
        if let sessID = id {
            completion(sessionID: sessID)
        }
        
        let creds = Creds()
        
        let url = NSURL(string: self.wsSessionIDURL)!

        let req = NSMutableURLRequest(URL: url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(creds.accountID, forHTTPHeaderField: "X-Auth-Account")
        req.setValue(creds.tokenID, forHTTPHeaderField: "X-Auth-Token")
        req.HTTPMethod = "POST"
        
        Alamofire.request(req).responseJSON() {
            request,response,data,error in
            if error == nil {
                let json = JSON(data!)
                
                if let sessID = json["body"]["id"].string {
                    Session.id = sessID
                    completion(sessionID: sessID)
                }
                
                completion(sessionID: nil)
            } else {
                completion(sessionID: nil)
            }
        }
        
    }

    class func setWebSocket () {
        
        if Session.id == nil {
       
            Session.setSessionID {
                sessionID in
                
                guard let _ = Session.id else {
                    print("CanNotGetSessionKey")
                    //throw SessionError.CanNotGetSessionKey
                    return
                }
                
            }
        }

        let url = "\(Session.wsSessionURLBase)/\(Session.id)/ws"
        Session.webSocket = WebSocket(url)
        
    }
}