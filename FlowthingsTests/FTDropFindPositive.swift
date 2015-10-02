//
//  FTDropFindPositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropFind {
    
    func testDropFindValidFlowValidParams_positive() {
        
        let expectation = expectationWithDescription("Calling drop.find")
        
        let params : ValidParams = [
            "filter" : "",
            "start" : 0,
            "limit" : 30,
            "hints" : 0
        ]
        
        api.drop.find(conf.flowID, params: params)
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
    
    func testDropFindValidFlowEmptyParams_positive() {
        
        let expectation = expectationWithDescription("Calling drop.find")
        
        let params : ValidParams = [:]
        
        api.drop.find(conf.flowID, params: params)
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
    
    func testDropFindValidFlowInvalidParams_positive() {
        
        let expectation = expectationWithDescription("Calling drop.find")
        
        let params : ValidParams = [
            "invalid" : "param"
        ]
        
        api.drop.find(conf.flowID, params: params)
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