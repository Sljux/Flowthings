//
//  FTFlowFindPositive.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTFlowFind {
    
    func testFlowFind_positive() {
        
        let expectation = expectationWithDescription("Calling flow.find")
        
        let params : ValidParams = [:]
        
        api.flow.find(params)
            .then { json -> () in
                
                guard let body = json["body"].array as? [ValidParams] where body.count > 0 else {
                    throw Error.BodyIsMissing
                }
                
                expectation.fulfill()
        	}
            .error { error in
                
            	XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { (error) -> Void in
            
            if let error = error {
                print(error)
            }
        }
    }
    
}