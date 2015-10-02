//
//  FTWebSocketTrack.swift
//  Flowthings
//
//  Created by Ceco on 29/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTWebSocketTrack: BaseTest {
    
    func testTrackCreateReadUpdateDelete_positive() {
        let expectation = expectationWithDescription("Create, read, update, and delete a Track")
        var ws : FTWebSocket?
        var trackId: String?
        
        api.ws.connect()
            .then { socket -> FTStream in
                
                ws = socket
                
                let params = ["source" : "/ceco/framework", "destination" : "/ceco/framework/create-test"]
                return socket.track.create(params)
            }
            .then { drop -> FTStream in
                
                trackId = drop["body"]["id"].string
                return ws!.track.read(trackId!)
            }
            .then { drop -> FTStream in
                
                let values : ValidParams = ["filter" : "somethingStrange == true"]
                return ws!.track.update(trackId!, params: values)
            }
            .then { drop -> FTStream in
                
                let newFilter = drop["body"]["filter"].string
                
                XCTAssertNotEqual("", newFilter)
                
                return ws!.track.delete(trackId!)
            }
            .then { drop in
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(10) { error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTrackCreate_negative() {
        let expectation = expectationWithDescription("Fail creating Track with empty params")
        
        api.ws.connect()
            .then { socket -> FTStream in
                
                let params : ValidParams = [:]
                return socket.track.create(params)
            }
            .then { drop -> () in
                
                XCTFail("Successfuly created Track with empty params")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(1) { error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
