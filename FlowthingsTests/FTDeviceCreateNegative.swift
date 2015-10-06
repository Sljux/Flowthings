//
//  FTFlowCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDeviceCreate {
    
    func testDeviceCreateNoPath_negative() {
        
        let expectation = expectationWithDescription("Calling device.create")
        
        let params : ValidParams = [:]
        
        api.device.create(params)
            .then { json -> () in
                
                XCTFail("Created Device with no path")
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

    func testDeviceCreateEmptyPath_negative() {
        
        let expectation = expectationWithDescription("Calling device.create")
        
        let params : ValidParams = [
            "path" : ""
        ]
        
        api.device.create(params)
            .then { json -> () in
                
                XCTFail("Created Device with empty path")
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
    
    func testDeviceCreateInvalidPath_negative() {
        
        let expectation = expectationWithDescription("Calling device.create")
        
        let params : ValidParams = [
            "path" : "badPathTest"
        ]
        
        api.device.create(params)
            .then { json -> () in
                
                XCTFail("Created Device with invalid path")
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
