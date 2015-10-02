//
//  FTWSDelete.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTWSDelete {
    
    var objectType : String { get }
    var socket : FTWebSocket { get }
    
}

extension FTWSDelete {
    
    public func delete(id: String) -> FTStream {
        let value : ValidParams = ["id" : id]
        return socket.sendMessage(objectType, type: "delete", values: value)
    }
    
}