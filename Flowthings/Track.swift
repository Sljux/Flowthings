//
//  Track.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public struct Track : FTCreate, FTRead, FTUpdate, FTDelete {
    
    public var baseURL : String = "/track/"
    public var createRequiredParams : [String] = ["source", "destination"]
    
}