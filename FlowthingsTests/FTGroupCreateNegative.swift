//
//  FTShareCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTGroupCreate {
    
    func testShareCreateNoMemberIds_negative() {
        
        let expectation = expectationWithDescription("Calling group.create")
        
        let params : ValidParams = [:]
        
        api.group.create(params)
            .then { json -> () in
                
                XCTFail("Created Group with no memberIds")
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