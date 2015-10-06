//
//  FTGroupFindPositive.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTGroupFind {
    
    func testGroupFind_positive() {
        
        let expectation = expectationWithDescription("Calling group.find")
        
        let params : ValidParams = [:]
        
        api.group.find(params)
            .then { json -> () in
                
                guard let _ = json["body"].array as? [ValidParams] else {
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