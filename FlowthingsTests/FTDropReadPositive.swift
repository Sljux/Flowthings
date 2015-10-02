//
//  FTDropReadPositive.swift
//  Flowthings
//
//  Created by Ceco on 30/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropRead {
    
    func testDropCreateAndRead_positive() {
        
        let testName = __FUNCTION__
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description": "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create then drop.read")
        
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
                
                return self.api.drop.read(conf.flowID, id: id)
            }
            .then  { json -> () in
                
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