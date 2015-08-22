//
//  ApiDropCreateNegative.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings
import SwiftyJSON

extension APIDropCreateTests {
    
    func testDropCreateWithBadFlowID() {
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowID with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowID"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: "badFlowIDTest",
            params: params,
            success:{
                json in
                
                guard let id = json["body"]["id"].string else {
                    XCTFail("drop id not returned")
                    return
                }
                
                XCTAssertGreaterThan(id.characters.count, 5, "drop ID is too small")
                
                expectation.fulfill()
            },
            failure:{
                error in
                print(error)
                XCTFail("Create Drop returned error")
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
        }
    }
    
}