//
//  FTDropUpdateNegative.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropUpdate {
    
    func testDropUpdateInvalidId_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.update")
        
        api.drop.update(conf.flowID, id: "badDropIDTest", params: params)
            .then  { json -> () in
                
                XCTFail("Updated Drop with Invalid ID")
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
    
    func testDropUpdateInvalidFlowId_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.update")
        
        api.drop.update("badFlowIDTest", id: "badDropIDTest", params: params)
            .then  { json -> () in
                
                XCTFail("Updated Drop with Invalid FlowId")
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
    
    func testDropCreateAndUpdateEmptyElems_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create then drop.update")
        
        api.drop.create(byFlowId: conf.flowID, params: params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let valid = Valid()
                valid.check("id", value: id)
                
                if !valid.isValid {
                    XCTFail(valid.messages.joinWithSeparator(", "))
                }
                
                let newParams : ValidParams = [
                    "elems" : [:]
                ]
                
                return self.api.drop.update(conf.flowID, id: id, params: newParams)
            }
            .then  { json -> () in
                
                XCTFail("Updated Drop with empty params")
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
    
    func testDropUpdateNoElems_negative() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create then drop.update")
        
        api.drop.create(byFlowId: conf.flowID, params: params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let valid = Valid()
                valid.check("id", value: id)
                
                if !valid.isValid {
                    XCTFail(valid.messages.joinWithSeparator(", "))
                }
                
                let newParams : ValidParams = [:]
                
                return self.api.drop.update(conf.flowID, id: id, params: newParams)
            }
            .then  { json -> () in
                
                XCTFail("Updated Drop with no elems")
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