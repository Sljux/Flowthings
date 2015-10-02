//
//  FTDropUpdate_positive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTDropUpdate {
    
    func testDropCreateAndUpdate_positive() {
        
        let testName = __FUNCTION__
        
        let data = 1,
        	newData = 2
        
        let params : [String:AnyObject] = [
            "location" : conf.location,
            "elems" : [
                "data" : data,
                "task" : "running \(testName) with timeout of \(conf.timeout)",
                "description" : "UnitTest \(testName)"
            ]
        ]
        
        let expectation = expectationWithDescription("Calling drop.create then drop.update")
        
        api.drop.create(byFlowId: conf.flowID, params: params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let valid = Valid()
                valid.check("id", value: id)
                
                if !valid.isValid {
                    XCTFail(valid.messages.joinWithSeparator(", "))
                }
                
                let newParams : ValidParams = [
                    "elems" : [
                        "data" : newData
                    ]
                ]
                
                return self.api.drop.update(conf.flowID, id: id, params: newParams)
            }
            .then  { json -> () in
                
                guard let elems = json["body"]["elems"].dictionary else {
                    throw Error.BodyIsMissing
                }
                
                if let data = elems["data"] as? Int where data != newData {
                    XCTFail("Drop not updated. Got \(data), but should get \(newData)")
                }
                
                expectation.fulfill()
            }
            .error { error in
                
                XCTFail("\(error)")
                expectation.fulfill()
        	}

        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
}