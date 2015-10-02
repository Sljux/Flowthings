//
//  WSTrack.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import SwiftWebSocket

public class WSTrack : FTWSCreate, FTWSRead, FTWSUpdate, FTWSDelete {
    
    public var objectType = "track"
    public var socket : FTWebSocket
    public var createRequiredParams : [String] = ["source", "destination"]
    
    init(socket: FTWebSocket) {
        self.socket = socket
    }

}