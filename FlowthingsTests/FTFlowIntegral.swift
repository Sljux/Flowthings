//
//  FTFlowIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Flowthings

class FTFlowIntegral: BaseTest {
    
    func testFlowCreateReadUpdateEmptyDelete_positive() {
        
        let expectation = expectationWithDescription("Testing all functions on single Flow")
        
        let path = "/ceco/framework/test"
        let params : ValidParams = [
            "path" : path
        ]
        
        var flowId : String?
        var capacity : Int?
        var newCapacity : Int?
        
        api.flow.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                flowId = id
                
                return self.api.flow.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let c = json["body"]["capacity"].int else {
                    throw Error.BodyIsMissing
                }
                
                capacity = c
                newCapacity = c + 1000
                
                XCTAssertEqual(id, flowId!, "FlowId shouldn't change")
                
                let params : ValidParams = [
                    "capacity" : newCapacity!
                ]
                
                return self.api.flow.update(id, params: params)
            }
            .then { json -> Promise<(JSON, JSON, JSON)> in
            
                guard let c = json["body"]["capacity"].int else {
                    throw Error.BodyIsMissing
                }
                
                XCTAssertEqual(c, newCapacity, "Should update capacity")
                XCTAssertNotEqual(c, capacity, "Should update capacity")
                
                let params : ValidParams = [
                    "location" : conf.location,
                    "elems" : [ "data" : 1 ]
                ]
                
                let promise1 = self.api.drop.create(byFlowId: flowId!, params: params),
                	promise2 = self.api.drop.create(byFlowId: flowId!, params: params),
                	promise3 = self.api.drop.create(byFlowId: flowId!, params: params)
                
                return when(promise1, promise2, promise3)
            }
            .then { json1, json2, json3 -> FTStream in
                
                guard let id = json1["body"]["flowId"].string else {
                    throw Error.ResourseIdMissing
                }
                
                XCTAssertEqual(id, flowId!, "FlowId shouldn't change")

                return self.api.flow.empty(id)
            }
            .then { json -> FTStream in
                
                return self.api.flow.delete(flowId!)
            }
            .then { json in
                
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
