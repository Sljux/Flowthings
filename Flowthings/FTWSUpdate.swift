//
//  FTWSUpdate.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTWSUpdate {
    
    var objectType : String { get }
    var socket : FTWebSocket { get }
    
}

extension FTWSUpdate {
    
    public func update(id: String, params: ValidParams) -> FTStream {
        let value : ValidParams = ["id" : id, "value" : params]
        return socket.sendMessage(objectType, type: "update", values: value)
    }
    
}