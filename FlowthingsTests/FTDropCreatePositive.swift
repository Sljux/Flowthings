//
//  ApiDropCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

extension FTDropCreateTests {
    
    func testFTDropCreateWithFlowID_positive() {
        
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
        
        api.drop.createOnFlowID(conf.flowID, params: params)
            .success{
                json in
                
                guard let id = json["body"]["id"].string else {
                    XCTFail(
                        self.report("drop id did not returned"))
                    return
                }
                
                if id.characters.count < 5 {
                    XCTFail(
                        self.report("drop ID is too small"))
                }
                
                expectation.fulfill()
            }
            .failure{
                error in
                print(error)
                XCTFail("Create Drop returned error")
                expectation.fulfill()
        }
        
        self.pass()
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            if error != nil {
                print(error)
            }
        }
    }
    
    func testDropCreateWithFlowIDAndFHASH_positive() {
        
        result.fhash = "testDropCreateWithFlowIDAndFHASH_positive"
        result.name = "Create Drop with flow_id and fhash"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() it also adds fhash"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "fhash" : "testDropCreateWithFlowIDAndFHASH_positive",
            "elems":[
                "task":"running testDropCreateWithFlowIDAndFHASH_positive with timeout of \(conf.timeout), update on \(dateFormatter.stringFromDate(date))",
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
    
    func testDropCreateWithFlowIDAndRead_positive() {
        
        result.fhash = "testDropCreateWithFlowIDAndRead_positive"
        result.name = "Create Drop with flow_id and read in chain"
        result.desc = "Test Creates Drop using flow_id in the URL using api.drop.createOnFlowID() it also adds fhash"
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowIDAndRead_positive with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowIDAndRead"
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
                
                let valid = Valid()
                valid.check("id", value: id)

                if !self.report(valid) {
                    XCTFail("Validation failed")
                }
                
                let path = "/drop/" + conf.flowID + "/" + id
                
                self.api.drop.read(path: path)
                    .success {
                        json in

                        guard let _ = json["body"]["id"].string else {
                            XCTFail(
                                self.report("drop id not returned on read"))
                            return
                        }
                        expectation.fulfill()
                    }
                    .failure {
                        error in
                        print(error)
                        XCTFail(
                            self.report("Create Drop.read returned error"))
                        //expectation.fulfill()
                }
            }
            .failure{
                error in
                print(error)
                XCTFail("Create Drop returned error")
                //expectation.fulfill()
        }
        
        self.pass()
        
        waitForExpectationsWithTimeout(conf.timeout) {
            error in
            
            if error != nil {
                print(error)
            }
        }
    }
    
    func testDropCreateOnPath_positive() {
        
        result.fhash = "testDropCreateOnPath_positive"
        result.name = "Create Drop on the path"
        result.desc = "Test Creates Drop using path api.drop.create()"

        
        let params : [String:AnyObject] = [
            "path" : conf.flowPath,
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
                
                guard let id = json["body"]["id"].string else {
                    XCTFail(
                        self.report("drop id not returned"))
                    return
                }
                
                let valid = Valid()
                valid.check("id", value: id)
                valid.check("path", value: conf.flowPath)
                //self.report(valid)
                if !self.report(valid) {
                    XCTFail("Validation failed")
                }
                else{
                    self.pass()
                    expectation.fulfill()
                }
                
            }
            .failure{
                error in
                print(error)
                XCTFail("Create Drop returned error")
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
        }
    }
    
}