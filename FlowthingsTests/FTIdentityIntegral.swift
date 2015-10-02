//
//  FTIdentityIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTIdentityIntegral: BaseTest {
	
    func testIdentityReadSelfRead_positive() {
        
        let expectation = expectationWithDescription("Calling identity.read")
        
        var firstName : String?
        
        api.identity.read()
            .then { json -> FTStream in
                
                guard let body = json["body"].array as? [ValidParams] else {
                    throw Error.BodyIsMissing
                }
                
                guard let id = body[0]["id"] as? String else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.identity.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let fn = json["body"]["firstName"].string else {
                    throw Error.BodyIsMissing
                }
                
                firstName = fn
                
                let params : ValidParams = [
                    "firstName" : fn + "Test"
                ]
                
                return self.api.identity.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let fn = json["body"]["firstName"].string else {
                    throw Error.BodyIsMissing
                }
                
                XCTAssertNotEqual(fn, firstName!, "Should update identity")
                
                let params : ValidParams = [
                    "firstName" : firstName!
                ]
                
                return self.api.identity.update(id, params: params)
            }
            .then { json -> () in
                
                guard let fn = json["body"]["firstName"].string else {
                    throw Error.BodyIsMissing
                }
                
                XCTAssertEqual(firstName!, fn, "Should update identity")
                
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