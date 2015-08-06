//
//  DropAPISpec.swift
//  Flowthings
//
//  Created by Ceco on 8/6/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Alamofire
import SwiftyJSON
@testable import Flowthings

class DropAPITests: QuickSpec {
    
    var api : API = Flowthings(accountID: "ceco", tokenID: "6GMlrMISkC95NsTvadZKetBrgo4G0TKW").api
    
    
    override func setUp() {
        separator()
        super.setUp()
    }
    
    override func tearDown() {
        separator()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDropAPIRead() {
        
        let flowID = "f55b991ab68056d7454984a87"
        let dropID = "d55b991ab68056d7454984a8d"

        print("CECO")
        api.drop.read(flowID: flowID, dropID: dropID,
            success:{
                body in
                
                XCTFail("DropAPIRead failed")
        },
            failure:{
                error in

                XCTFail("DropAPIRead failed")
        })
    }
//    func testDropAPICreate() {
//
//        let model : [String:AnyObject] = [
//            "path" : "/ceco/framework/test1/",
//            "description" : "framework testing flow"
//        ]
//        
//        api.flow.create(model,
//            success:{
//                body in
//                print(body)
//                //XCTAssert((body as? JSON), "Not JSON")
//            },
//            failure:{
//                error in
//                XCTFail("Error on Drop create")
//            })
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}