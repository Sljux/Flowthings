//
//  FTFlowIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTDeviceIntegral: BaseTest {
    
    func testDeviceCreateReadUpdateDelete_positive() {
        
        let expectation = expectationWithDescription("Testing all functions on single Device")
        
        let params : ValidParams = [
            "path" : conf.flowPath
        ]
        
        let displayName = "deviceName"
        
        api.device.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.device.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let params : ValidParams = [
                    "displayName" : displayName
                ]
                
                return self.api.device.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let newDisplayName = json["body"]["displayName"].string else {
                    throw Error.BodyParamIsMissing("displayName")
                }
                
                XCTAssertEqual(displayName, newDisplayName)

                return self.api.device.delete(id)
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
