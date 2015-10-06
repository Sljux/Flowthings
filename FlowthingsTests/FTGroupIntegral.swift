//
//  FTShareIntegral.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTGroupIntegral: BaseTest {
    
    func testGroupCreateReadUpdateDelete() {
        let expectation = expectationWithDescription("Calling group.create")
        
        let params : ValidParams = [
            "memberIds" : ["i550445140cf21961de8c1f46"]
        ]
        
        let description = "Test Group"
        
        api.group.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.group.read(id)
        	}
            .then { json -> FTStream in

                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let params : ValidParams = [
                    "description" : description
                ]
                
                return self.api.group.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let newDescription = json["body"]["description"].string else {
                    throw Error.BodyParamIsMissing("description")
                }
                
                XCTAssertEqual(description, newDescription)
                
                return self.api.group.delete(id)
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
