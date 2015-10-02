//
//  FTWSRead.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTWSRead {
    
    var objectType : String { get }
    var socket : FTWebSocket { get }
    
}

extension FTWSRead {
    
    public func read(id: String) -> FTStream {
        let value : ValidParams = ["id" : id]
        return socket.sendMessage(objectType, type: "find", values: value)
    }
    
}