//
//  WebSocketConnection.swift
//  Flowthings
//
//  Created by Ceco on 23/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import PromiseKit
import SwiftWebSocket

public class WSConnection {
    public func connect() -> Promise<FTWebSocket> {
        
        return Promise<FTWebSocket> { fulfill, reject in
            
            FTAPI.request(.POST, path: "session", params: nil, type: .WS)
                .then { value -> () in
                    
                    guard let id = value["body"]["id"].string else {
                        return reject(Error.SessionIdMissing)
                    }
                    
                    fulfill(FTWebSocket(id: id))
                }
                .error { reject($0) }
        }
    }
}