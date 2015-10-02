//
//  FTWebSocketFlow.swift
//  Flowthings
//
//  Created by Ceco on 28/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTWebSocketFlow: BaseTest {
    
    func testFlowCreateReadUpdateDelete_positive() {
        let expectation = expectationWithDescription("Create, read, update, and delete a Flow")
        var ws : FTWebSocket?
        var capacity : Int?
        var flowId: String?
        
        api.ws.connect()
            .then { socket -> FTStream in
                
                ws = socket
                
                let params = ["path" : "/ceco/framework/test"]
                return socket.flow.create(params)
        	}
            .then { drop -> FTStream in
            	
                flowId = drop["body"]["id"].string
                
                return ws!.flow.read(flowId!)
            }
            .then { drop -> FTStream in
                
                capacity = drop["body"]["capacity"].int
                
                let values : ValidParams = ["capacity" : capacity! + 1000]
                return ws!.flow.update(flowId!, params: values)
            }
            .then { drop -> FTStream in
                
                let newCapacity = drop["body"]["capacity"].int
                
                XCTAssertNotEqual(capacity, newCapacity)
                
                return ws!.flow.delete(flowId!)
        	}
            .then { drop -> () in
                
                expectation.fulfill()
        	}
            .error { error in
                
                XCTFail("\(error)")
        	}
        
        waitForExpectationsWithTimeout(10) { error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testFlowCreate_negative() {
        let expectation = expectationWithDescription("Fail creating Flow with empty params")
        
        api.ws.connect()
            .then { socket -> FTStream in
                
                let params : ValidParams = [:]
                return socket.flow.create(params)
        	}
            .then { drop -> () in
                
                XCTFail("Successfuly created Flow with empty params")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(10) { error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
