//
//  FTFlowCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTFlowCreate {
    
    func testFlowCreateEmptyParams_negative() {
        
        let expectation = expectationWithDescription("Calling flow.create")
        
        let params : ValidParams = [:]
        
        api.flow.create(params)
            .then { json -> () in
                
                XCTFail("Created Flow with no params")
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

    func testFlowCreateEmptyPath_negative() {
        
        let expectation = expectationWithDescription("Calling flow.create")
        
        let params : ValidParams = [
            "path" : ""
        ]
        
        api.flow.create(params)
            .then { json -> () in
                
                XCTFail("Created Flow with empty path")
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
    
    func testFlowCreateInvalidPath_negative() {
        
        let expectation = expectationWithDescription("Calling flow.create")
        
        let params : ValidParams = [
            "path" : "badPathTest"
        ]
        
        api.flow.create(params)
            .then { json -> () in
                
                XCTFail("Created Flow with invalid path")
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
