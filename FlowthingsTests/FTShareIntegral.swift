//
//  FTShareIntegral.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTShareIntegral: BaseTest {
    
    func testShareCreateReadDelete() {
        let expectation = expectationWithDescription("Calling share.create")
        
        let params : ValidParams = [
            "paths" : [
                "/ceco/framework/unit-tests/dump" : [
                    "dropRead": true,
                    "dropWrite": false
                ]
            ],
            "issuedTo" : "i550445140cf21961de8c1f46"
        ]
        
        api.share.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.share.read(id)
        	}
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.share.delete(id)
            }
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
