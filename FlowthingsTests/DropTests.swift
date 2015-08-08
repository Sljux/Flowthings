//
//  DropTests.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings
import SwiftyJSON

class DropTests: XCTestCase {
    
    let api = FlowthingsAPI(accountID: conf.accountID, tokenID: conf.tokenID)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testDropCreateWithFlowIDAndFHASH() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let model : [String:AnyObject] = [
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
            model: model,
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

    func testDropCreateWithFlowID() {
        
        let model : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowID with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowID"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: conf.flowID,
            model: model,
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

    func testDropCreateWithFlowIDAndRead() {
        
        let model : [String:AnyObject] = [
            "location" : conf.location,
            "elems":[
                "task":"running testDropCreateWithFlowIDAndRead with timeout of \(conf.timeout)",
                "description": "UnitTest testDropCreateWithFlowIDAndRead"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create")
        
        api.drop.createOnFlowID(
            flowID: conf.flowID,
            model: model,
            success:{
                json in
                
                guard let id = json["body"]["id"].string else {
                    XCTFail("drop id not returned")
                    return
                }
                
                XCTAssertGreaterThan(id.characters.count, 5, "drop ID is too small")
                
                let path = "/drop/" + conf.flowID + "/" + id
                
                self.api.drop.read(path,
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
            model: model,
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


    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
