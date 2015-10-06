//
//  FTShareCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTMQTTCreate {
    
    func testMQTTCreateNoDestination_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "topic" : "topic",
            "uri" : "tcp://testbrokerhost:1883"
        ]
        
        api.mqtt.create(params)
            .then { json -> () in
                
                XCTFail("Created MQTT with no destinayion")
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
    
    func testMQTTCreateNoTopic_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "uri" : "tcp://testbrokerhost:1883"
        ]
        
        api.mqtt.create(params)
            .then { json -> () in
                
                XCTFail("Created MQTT with no topic")
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
    
    func testMQTTCreateNoURI_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "topic" : "topic"
        ]
        
        api.mqtt.create(params)
            .then { json -> () in
                
                XCTFail("Created MQTT with no uri")
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
    
    func testMQTTCreateBadDestination_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "destination" : "badDestinationTest",
            "topic" : "topic",
            "uri" : "tcp://testbrokerhost:1883"
        ]
        
        api.mqtt.create(params)
            .then { json -> () in
                
                XCTFail("Created MQTT with bad destinayion")
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
    
    
    func testMQTTCreateBadUri_negative() {
        
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "topic" : "topic",
            "uri" : "badUriTest"
        ]
        
        api.mqtt.create(params)
            .then { json -> () in
                
                XCTFail("Created MQTT with bad uri")
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