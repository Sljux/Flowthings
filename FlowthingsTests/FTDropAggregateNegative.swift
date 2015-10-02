//
//  FTDropAggregateNegative.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropAggregate {

    func testAggregateNoGroupBy_negative() {
        let expectation = expectationWithDescription("Calling drop.aggregate")
        
        let params : ValidParams = [
            "output" : ["$count"]
        ]
        
        api.drop.aggregate(conf.flowID, params: params)
            .then { json -> () in
                
                XCTFail("Aggregated Drops without groupBy: \(json)")
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
    
    func testAggregateNoOutput_negative() {
        let expectation = expectationWithDescription("Calling drop.aggregate")
        
        let params : ValidParams = [
            "groupBy" : ["pass"]
        ]
        
        api.drop.aggregate(conf.flowID, params: params)
            .then { json -> () in
                
                XCTFail("Aggregated Drops without output: \(json)")
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
    
    func testAggregateInvalidGroupBy_negative() {
        let expectation = expectationWithDescription("Calling drop.aggregate")
        
        let params : ValidParams = [
            "groupBy" : "invalidType",
            "output" : ["$count"]
        ]
        
        api.drop.aggregate(conf.flowID, params: params)
            .then { json -> () in
                
                XCTFail("Aggregated Drops without groupBy: \(json)")
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
    
    func testAggregateInvalidOutput_negative() {
        let expectation = expectationWithDescription("Calling drop.aggregate")
        
        let params : ValidParams = [
            "groupBy" : ["pass"],
            "output" : "invalidType"
        ]
        
        api.drop.aggregate(conf.flowID, params: params)
            .then { json -> () in
                
                XCTFail("Aggregated Drops without output: \(json)")
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