//
//  WSDrop.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import SwiftWebSocket

public class WSDrop : FTWSDropCreate, FTWSRead, FTWSUpdate, FTWSDelete {
    
    public var objectType = "drop"
    public var socket : FTWebSocket
    public var createRequiredParams : [String] = ["flowId", "elems"]
    
    init(socket: FTWebSocket) {
        self.socket = socket
    }
    
}