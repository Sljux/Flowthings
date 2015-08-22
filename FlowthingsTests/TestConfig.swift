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
    let tokenID = "TWEFiZvO0KtvWMx5p24JvBbFhBA1oDL3"

    //Logger flow
    let unitTestsFlowID = "f55d896f168056d2c5b94b7f5"
    
    //Dump Flow used for tests
    let flowID = "f55d8babd68056d2c5b94de0a"
    let flowPath = "/ceco/framework/unit-tests/dump"
    
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