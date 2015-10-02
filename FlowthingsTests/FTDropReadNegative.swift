//
//  FTDropReadNegative.swift
//  Flowthings
//
//  Created by Ceco on 30/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest

extension FTDropRead {
    
    func testDropReadBadId_negative() {
        
        let expectation = expectationWithDescription("Calling drop.read")
        
        api.drop.read(conf.flowID, id: "badDropIDTest")
            .then { json -> () in
                
                XCTFail("Read Drop with bas ID: \(json)")
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
    
    func testDropReadBadFlowId_negative() {
        
        let expectation = expectationWithDescription("Calling drop.read")
        
        api.drop.read("badFlowIDTest", id: "badDropIDTest")
            .then { json -> () in
                
                XCTFail("Read Drop with bas ID: \(json)")
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