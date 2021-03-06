//
//  FTWebSocketConnect.swift
//  Flowthings
//
//  Created by Ceco on 23/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTWebSocketConnect: BaseTest {
    
    func testConnect() {
        let expectation = expectationWithDescription("Connect WebSocket")
        
        api.ws.connect()
            .then {
        		socket in
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(2) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
