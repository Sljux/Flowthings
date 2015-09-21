//
//  ApiDropCreateNegative.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

extension FTDropCreateTests {
    
    func testFTDropCreateWithFlowID_negative() {
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowID with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowID"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID("badFlowIDTest", params: params)
            .success{
                json in
                
                XCTFail(
                    self.report("Create Drop passed failable test"))
                
                //expectation.fulfill()
            }
            .failure{
                error in
                print(error)
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            print(error)
        }
    }
    
    
    func testDropCreateWithFlowIDAndFHASH_negative() {
        
        result.fhash = "testDropCreateWithFlowIDAndFHASH_negative"
        result.name = "Create Drop with flow_id and fhash"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() it also adds fhash"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "fhash" : result.fhash,
            "elems":[
                "task":"running \(result.fhash) with timeout of \(conf.timeout), update on \(dateFormatter.stringFromDate(date))",
                "description": "UnitTest testDropCreateWithFlowIDAndFHASH"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(conf.flowID, params: params)
            .success{
                json in
                
                guard let id = json["body"]["id"].string else {
                    XCTFail(
                        self.report("drop id not returned"))
                    return
                }
                
                if id.characters.count <= 5 {
                    XCTFail(
                        self.report("drop ID string \(id) is too short"))
                }
                
                expectation.fulfill()
            }
            .failure{
                error in
                print(error)
                XCTFail(self.report("Create Drop returned error"))
                
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) {
            error in
            if let _ = error {
                XCTFail(
                    self.report("UnKnown error"))
            }
        }
        
        self.pass()
    }
    
    func testDropCreateWithFlowIDAndRead_negative() {
        
        result.fhash = "testDropCreateWithFlowIDAndRead_negative"
        result.name = "Create Drop with flow_id and read in chain"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() it also adds fhash, test all bad scenarios"
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems": ""
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(conf.flowID, params: params)
            .success{
                json in
                
                XCTFail(self.report("Passing failable"))
            }
            .failure{
                error in
                expectation.fulfill()
                self.pass()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) {
            error in
            
            if error != nil {
                print(error)
            }
        }
    }
    
    func testDropCreateOnPath_negative() {
        
        result.fhash = "testDropCreateOnPath_negative"
        result.name = "Create Drop on the path - empty path test"
        result.desc = "Test Creates Drop using path api.drop.create()"
        
        
        let params : [String:AnyObject] = [
            "path" : "",
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateOnPath_positive on \(conf.flowPath) timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateOnPath_positive"
            ]
        ]
        
        let expectation = expectationWithDescription("api.drop.create")
        
        api.drop.create(params: params)
            .success{
                json in
                    XCTFail(self.report("Passing failable empty path"))
                    expectation.fulfill()
            }
            .failure{
                error in
                //it shoudl fail
                expectation.fulfill()
                self.pass()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
        }
    }
}