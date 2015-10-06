//
//  FTFlowCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTRSSCreate {
    
    func testRSSCreateNoDestination_negative() {
        
        let expectation = expectationWithDescription("Calling rss.create")
        
        let params : ValidParams = [
            "url" : "http://testrss.com"
        ]
        
        api.rss.create(params)
            .then { json -> () in
                
                XCTFail("Created RSS with no destination")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }

    func testRSSCreateEmptyDestination_negative() {
        
        let expectation = expectationWithDescription("Calling rss.create")
        
        let params : ValidParams = [
            "destination" : "",
            "url" : "http://testrss.com"
        ]
        
        api.rss.create(params)
            .then { json -> () in
                
                XCTFail("Created RSS with empty destination")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testApiTaskCreateInvalidPath_negative() {
        
        let expectation = expectationWithDescription("Calling rss.create")
        
        let params : ValidParams = [
            "destination" : "badPathTest",
            "url" : "http://testrss.com"
        ]
        
        api.rss.create(params)
            .then { json -> () in
                
                XCTFail("Created RSS with invalid destination")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testRSSCreateNoUrl_negative() {
        
        let expectation = expectationWithDescription("Calling rss.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath
        ]
        
        api.rss.create(params)
            .then { json -> () in
                
                XCTFail("Created RSS with no url")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }

}
