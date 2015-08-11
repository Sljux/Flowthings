//
//  TestConfig.swift
//  Flowthings
//
//  Created by Ceco on 8/8/15.
//  Copyright © 2015 cityos. All rights reserved.
//
import Foundation

let conf = TestConfig()

struct TestConfig {

    let timeout : NSTimeInterval = 10
    
    let accountID = "ceco"
    let tokenID = "6GMlrMISkC95NsTvadZKetBrgo4G0TKW"

    //Used in drop tests
    let flowID = "f55b991ab68056d7454984a87"
    let flowPath = "/ceco/framework/test1"
    
    let location = [
        "lat": 40.703285,
        "lon": -73.987852,
        "specifiers": [
            "city": "New York City",
            "zip": "11201",
            "street": "155 Water Street",
            "state": "NY"
        ]
    ]
}