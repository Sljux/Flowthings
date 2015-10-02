//
//  FTWSDropCreate.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public protocol FTWSDropCreate {
    
    var objectType : String { get }
    var socket : FTWebSocket { get }
    var createRequiredParams : [String] { get }
    
}

extension FTWSDropCreate {
    
    public func create(flowId: String, params: ValidParams) -> FTStream {
        let valid = Valid(checkFor: createRequiredParams, params: params)
        
        return valid.stream {
            let value : ValidParams = ["flowId" : flowId, "value" : params]
            return self.socket.sendMessage(self.objectType, type: "create", values: value)
        }
    }
    
}