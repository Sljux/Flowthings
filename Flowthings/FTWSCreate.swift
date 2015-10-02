//
//  FTWSCreate.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

public protocol FTWSCreate {
    
    var objectType : String { get }
    var socket : FTWebSocket { get }
    var createRequiredParams : [String] { get }
    
}

extension FTWSCreate {
    
    public func create(params: ValidParams) -> FTStream {
        let valid = Valid(checkFor: createRequiredParams, params: params)
        
        return valid.stream {
            let values : ValidParams = ["value" : params]
            return self.socket.sendMessage(self.objectType, type: "create", values: values)
        }
	}
    
}