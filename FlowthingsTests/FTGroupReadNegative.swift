//
//  FTShareReadNegative.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTGroupRead {
    
    func testGroupReadBadId_negative() {
        
        let expectation = expectationWithDescription("Calling group.read")
        
        api.group.read("badGroupIdTest")
            .then { json -> () in
                
                XCTFail("Read Group with bad ID")
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