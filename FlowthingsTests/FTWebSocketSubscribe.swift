//
//  FTWebSocketSubscribe.swift
//  Flowthings
//
//  Created by Ceco on 23/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import PromiseKit
import SwiftWebSocket
@testable import Flowthings

class FTWebSocketSubscribe: XCTestCase {
    
    let api = FTAPI(accountID: conf.accountID, tokenID: conf.tokenID)
    
    let flowId = "f55b991805bb7092cc972da55"
    let flowId2 = "f55d896f168056d2c5b94b7f5"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSubscribeUnsubscribe() {
    	let expectation = expectationWithDescription("Subscribe to and unubscribe from Flow")
        var ws : FTWebSocket?
        
        api.ws.connect()
            .then { socket in
                
                ws = socket
                return ws!.flow.subscribe(self.flowId) { drop in  }
        	}
            .then { (data: JSON) -> () in
                
                XCTAssertNotNil(ws!.subscriptions[self.flowId])
                
                ws!.flow.unsubscribe(self.flowId)
                XCTAssertNil(ws!.subscriptions[self.flowId])
                
                expectation.fulfill()
            }
            .error { error in
                XCTFail("\(error)")
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }

    }
    
    func testTwoSubscriptions() {
        let expectation = expectationWithDescription("Subscribe to and unsubscribe from two Flows")
        var ws : FTWebSocket?
        
        api.ws.connect()
            .then { socket -> Promise<(JSON, JSON)> in
                
                ws = socket
                
                let promise1 = socket.flow.subscribe(self.flowId, dropHandler: { drop in })
                let promise2 = socket.flow.subscribe(self.flowId2, dropHandler: { drop in })
                
                return when(promise1, promise2)
        	}
            .then { data1, data2 -> Promise<(JSON, JSON)> in
                
                XCTAssertNotNil(ws!.subscriptions[self.flowId])
                XCTAssertNotNil(ws!.subscriptions[self.flowId2])
                
                let promise1 = ws!.flow.unsubscribe(self.flowId)
                let promise2 = ws!.flow.unsubscribe(self.flowId2)
                
                return when(promise1, promise2)
	        }
            .then { data1, data2 -> () in
                
                XCTAssertNil(ws!.subscriptions[self.flowId])
                XCTAssertNil(ws!.subscriptions[self.flowId2])
                
                expectation.fulfill()
        	}
            .error{ error in
                print(error)
        	}
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
