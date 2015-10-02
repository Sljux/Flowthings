//
//  ApiDropCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

extension FTDropCreate {
    
    func testDropCreate_positive() {
        
        let testName = __FUNCTION__
        
        print(testName)
        
        let params : ValidParams = [
            "path" : conf.flowPath,
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) on \(conf.flowPath) timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(params)
            .then { json -> () in
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testFTDropCreateByFlowID_positive() {
        
        let testName = __FUNCTION__
        
        let params : ValidParams = [
            "location" : conf.location,
            "elems": [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(byFlowId: conf.flowID, params: params)
            .then { json -> () in
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testDropCreateByFlowIDAndFHASH_positive() {
        
        let testName = __FUNCTION__
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let params : ValidParams = [
            "location" : conf.location,
            "fhash" : testName,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout), update on \(dateFormatter.stringFromDate(date))",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(byFlowId: conf.flowID, params: params)
            .then { json -> () in
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
}