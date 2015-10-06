//
//  FTShareIntegral.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTMQTTIntegral: BaseTest {
    
    func testMQTTCreateReadUpdateDelete() {
        let expectation = expectationWithDescription("Calling mqtt.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "topic" : "topic",
            "uri" : "tcp://testbrokerhost:1883"
        ]
        
        let displayName = "mqtt"
        
        api.mqtt.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.mqtt.read(id)
        	}
            .then { json -> FTStream in

                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let params : ValidParams = [
                    "displayName" : displayName
                ]
                
                return self.api.mqtt.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let newDisplayName = json["body"]["displayName"].string else {
                    throw Error.BodyParamIsMissing("displayName")
                }
                
                XCTAssertEqual(newDisplayName, displayName)
                
                return self.api.mqtt.delete(id)
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
