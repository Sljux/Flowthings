//
//  FTShareReadNegative.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTMQTTRead {
    
    func testMQTTReadBadId_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.read")
        
        api.mqtt.read("badMQTTIdTest")
            .then { json -> () in
                
                XCTFail("Read MQTT with bad ID")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
}