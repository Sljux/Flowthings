//
//  FTDropDeleteNegative.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropDelete {

    func testDropDeleteBadId_negative() {
        
        let expectation = expectationWithDescription("Calling drop.delete")
        
        api.drop.delete(conf.flowID, id: "badDropIDTest")
            .then { json -> () in
                
                XCTFail("Deleted Drop with bas ID: \(json)")
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
    
    func testDropDeleteBadFlowId_negative() {
        
        let expectation = expectationWithDescription("Calling drop.delete")
        
        api.drop.read("badFlowIDTest", id: "badDropIDTest")
            .then { json -> () in
                
                XCTFail("Deleted Drop with bas ID: \(json)")
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