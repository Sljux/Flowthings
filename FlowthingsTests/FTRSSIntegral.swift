//
//  FTFlowIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTRSSIntegral: BaseTest {
    
    func testRSSCreateReadUpdateDelete_positive() {
        
        let expectation = expectationWithDescription("Testing all functions on single RSS")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "url" : "http://testrss.com"
        ]
        
        let periodicity = 80000000
        
        api.rss.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.rss.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let params : ValidParams = [
                    "periodicity" : periodicity
                ]
                
                return self.api.rss.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let newPeriodicity = json["body"]["periodicity"].int else {
                    throw Error.BodyParamIsMissing("periodicity")
                }
                
                XCTAssertEqual(periodicity, newPeriodicity)

                return self.api.rss.delete(id)
            }
            .then { json in
                
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
