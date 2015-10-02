//
//  FTDropFindNegative.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropFind {
    
    func testDropFindInalidFlowValidParams_negative() {
        
        let expectation = expectationWithDescription("Calling drop.find")
        
        let params : ValidParams = [
            "filter" : "",
            "start" : 0,
            "limit" : 30,
            "hints" : 0
        ]
        
        api.drop.find("badFlowIDTest", params: params)
            .then { json -> () in
                
                XCTFail("Found Drops in invalid Flow")
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
    
    func testDropFindInalidFlowEmptyParams_negative() {
        
        let expectation = expectationWithDescription("Calling drop.find")
        
        let params : ValidParams = [:]
        
        api.drop.find("badFlowIDTest", params: params)
            .then { json -> () in
                
                XCTFail("Found Drops in invalid Flow")
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