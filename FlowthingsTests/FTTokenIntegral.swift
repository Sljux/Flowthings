//
//  FTTokenIntegral.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTTokenIntegral: BaseTest {
    
    func testTokenCreateReadDelete() {
        
        let expectation = expectationWithDescription("Calling token.create")
        
        let params : ValidParams = [
            "paths" : [
                "/ceco/framework/unit-tests/dump" : [
                    "dropRead": true,
                    "dropWrite": false
                ]
            ]
        ]
        
        api.token.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.BodyIsMissing
                }
                
                guard let _ = json["body"]["tokenString"].string else {
                    throw Error.TokenIsMissing
                }
                
                return self.api.token.read(id)
        	}
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.BodyIsMissing
                }
                
                guard let _ = json["body"]["tokenString"].string else {
                    throw Error.TokenIsMissing
                }
                
                return self.api.token.delete(id)
            }
            .then { json -> ()in
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
}
