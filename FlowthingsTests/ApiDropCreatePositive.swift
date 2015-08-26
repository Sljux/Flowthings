//
//  ApiDropCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings
import SwiftyJSON

extension APIDropCreateTests {

    func testDropCreateWithFlowID() {
        
        result.fhash = "testDropCreateWithFlowID"
        result.name = "Create Drop with flow_id without fhash"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() - it does not add fhash param"
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowID with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowID"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: conf.flowID,
            params: params,
            success:{
                json in
                
                guard let id = json["body"]["id"].string else {
                    self.fail("drop id not returned")
                    return
                }
                
                self.fail("Test")
                
                if id.characters.count < 5 {
                    self.fail("drop ID is too small")
                }
                
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
    
    func testDropCreateWithFlowIDAndFHASH() {
        
        result.fhash = "testDropCreateWithFlowIDAndFHASH"
        result.name = "Create Drop with flow_id and fhash"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() it also adds fhash"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "fhash" : "testDropCreateWithFlowIDAndFHASH",
            "elems":[
                "task":"running testDropCreateWithFlowIDAndFHASH with timeout of \(conf.timeout), update on \(dateFormatter.stringFromDate(date))",
                "description": "UnitTest testDropCreateWithFlowIDAndFHASH"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: conf.flowID,
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
                self.fail("Create Drop returned error")
                
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(conf.timeout) {
            error in
            if let _ = error {
                self.fail("UnKnown error")
            }
        }
        
        self.pass()
    }
    
    func testDropCreateWithFlowIDAndRead() {
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowIDAndRead with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowIDAndRead"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: conf.flowID,
            params: params,
            success:{
                json in
                
                guard let id = json["body"]["id"].string else {
                    XCTFail("drop id not returned")
                    return
                }
                
                XCTAssertGreaterThan(id.characters.count, 5, "drop ID is too small")
                
                let path = "/drop/" + conf.flowID + "/" + id
                
                self.api.drop.read(path: path,
                    success: {
                        json in
                        print(json)
                        if let _ = json["body"]["id"].string  {
                            expectation.fulfill()
                        }
                        XCTFail("drop id not returned on read")
                    },
                    failure: {
                        error in
                        print(error)
                        XCTFail("Create Drop.read returned error")
                        expectation.fulfill()
                })
                
                
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
    
    func testDropCreateOnPath() {
        
        let model : [String:AnyObject] = [
            "path" : conf.flowPath,
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateOnPath on \(conf.flowPath) timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateOnPath"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.create(
            params: model,
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