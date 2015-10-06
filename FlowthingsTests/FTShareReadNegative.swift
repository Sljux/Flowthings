//
//  FTShareReadNegative.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTShareRead {
    
    func testShareReadBadId_negative() {
        
        let expectation = expectationWithDescription("Calling share.read")
        
        api.share.read("badShareIdTest")
            .then { json -> () in
                
                XCTFail("Read Share with bad ID")
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