//
//  FTSubscribe.swift
//  Flowthings
//
//  Created by Ceco on 24/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//


public protocol FTWSSubscribe : class {
    
    var socket : FTWebSocket { get }
    
}

extension FTWSSubscribe {
    public func subscribe(id: String, dropHandler: DropHandler) -> FTStream {
        socket.addDropListener(id, dropHandler: dropHandler)
        
        let values = [ "flowId" : id ]
        return socket.sendMessage("drop", type: "subscribe", values: values)
    }
    
    public func unsubscribe(id: String) -> FTStream {
        socket.removeDropListener(id)
        
        let values = [ "flowId" : id ]
        return socket.sendMessage("drop", type: "unsubscribe", values: values)
    }
}