//
//  Track.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

struct Track {
    
    
    var source : String?
    // The source Flow path, Drops that are published into this Flow will be monitored by the Track. If no filter or js is applied to this Track, it will consume all Drops written to this Flow.
    
    var destination : [String]?
    //A list of possible destination Flow paths, Drops that satisfy the Track's filter, and any conditions which may be present within the Track's js function, will be forwarded to these Flows.
    
    var filter : String?
    //Filters are used to require that Drops processed by the Track have specific data elements and values. See Flow Filter Language for more information on using the Flow Filter Language.
    
    var js : String?
    //A javascript function that takes a Drop matching the filter from the source Flow as its first argument and then returns a Drop to be written to the destination Flow(s). The API may be accessed from within the js in order to enhance Drops with data from other Flows by utilizing Flow.js.
    
}