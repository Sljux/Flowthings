//
//  FTWSFlow.swift
//  Flowthings
//
//  Created by Ceco on 24/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import SwiftWebSocket

public class WSFlow : FTWSSubscribe, FTWSCreate, FTWSRead, FTWSUpdate, FTWSDelete {
    
    public var socket : FTWebSocket
    public var objectType = "flow"
    public var createRequiredParams : [String] = ["path"]
    
    init(socket: FTWebSocket) {
        self.socket = socket
    }
}