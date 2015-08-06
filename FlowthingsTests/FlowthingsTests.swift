//
//  FlowthingsTests.swift
//  FlowthingsTests
//
//  Created by Ceco on 7/28/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FlowthingsTests: XCTestCase {
    
    var api : API = Flowthings(accountID: "ceco", tokenID: "6GMlrMISkC95NsTvadZKetBrgo4G0TKW").api
    
    override func setUp() {
        super.setUp()
        
        /*
        var model = [ "path" : "/ceco/framework/test1/",
        "description" : "framework testing flow",
        ]
        
        api.flow.create(model,
        success:{
        body in
        },
        failure:{
        error in
        })
        */
//        var location = Location()
//        
//        location.setCurent()
//        
//        let model = [ "path" : "/ceco/framework/test/",
//            "location" : location.dict,
//            "elems" : ["name" : "test", "status": "feel good"]]
//        
//        api.drop.create(model as! [String : AnyObject],
//            success:{
//                body in
//            },
//            failure:{
//                error in
//        })

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
