//
//  ApiDropCreateNegative.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

extension FTDropCreate {
    
    func testFTDropCreateByFlowID_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(byFlowId: "badFlowIDTest", params: params)
            .then { json -> () in
                
                XCTFail("Created Drop with invalid flowId")
                expectation.fulfill()
            }
            .error { error in
                
                print(error)
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testDropCreateByFlowIDAndFHASH_negative() {
        
        let testName = __FUNCTION__
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "fhash" : testName,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout), update on \(dateFormatter.stringFromDate(date))",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(byFlowId: "badFlowIDTest", params: params)
            .then { json -> () in
                
                XCTFail("Created Drop with invalid flowId")
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
    
    func testDropCreateOnPath_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "path" : "",
            "location" : conf.location,
            "elems" : [
                "task" : "running testDropCreateOnPath_positive on \(conf.flowPath) timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("api.drop.create")
        
        api.drop.create(params)
            .then { json -> () in
                
                XCTFail("Created Drop on invalid path")
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