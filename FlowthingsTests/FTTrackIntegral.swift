//
//  FTTrackIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTTrackIntegral: BaseTest {
    
    func testTrackCreateReadUpdateDelete_positive() {
        
        let expectation = expectationWithDescription("Testing all functions on single Track")
        
        let params : ValidParams = [
            "source" : "/ceco/framework",
            "destination" : "/ceco/framework/create-test",
            "filter" : ""
        ]
        
        var trackId : String?
        let filter = "somethingStrange == true"
        
        api.track.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                trackId = id
                
                return self.api.track.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                XCTAssertEqual(id, trackId!, "ID shouldn't change")
                
                let params : ValidParams = ["filter" : filter]
                
                return self.api.track.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let f = json["body"]["filter"].string else {
                    throw Error.BodyIsMissing
                }
                
                XCTAssertEqual(id, trackId!, "ID shouldn't change")
                XCTAssertEqual(f, filter, "Should update filter")
                
                return self.api.track.delete(trackId!)
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
