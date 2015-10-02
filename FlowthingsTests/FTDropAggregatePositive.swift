//
//  FTDropAggregatePositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropAggregate {
    
    func testAggregate_positive() {
        let expectation = expectationWithDescription("Calling drop.aggregate")
        
        let params : ValidParams = [
            "groupBy" : ["pass"],
            "output" : ["$count"]
        ]
        
        api.drop.aggregate(conf.flowID, params: params)
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