//
//  Track.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public struct Track {
    
    var base = Base(baseURL : "/track/")
    
    func simulate (path: String, params: ValidParams) -> FTStream {
            
        return FTAPI.request(.PUT, path: path, params: params)
    }
}