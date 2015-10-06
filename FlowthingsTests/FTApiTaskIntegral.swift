//
//  FTFlowIntegral.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class FTApiTaskIntegral: BaseTest {
    
    func testApiTaskCreateReadUpdateDelete_positive() {
        
        let expectation = expectationWithDescription("Testing all functions on single ApiTask")
        
        let params : ValidParams = [
            "destination" : conf.flowPath,
            "js" :
                "new Task({ " +
                "request: {uri: 'http://api.example.com/data.json', method: 'GET'}, " +
                "callback: function(responseText) { " +
                    "var json = JSON.parse(responseText); " +
                    "return json['items'].map(function(item) { " +
                        "return { " +
                            "elems: { " +
                                "title: {type: 'string', value: item.title}, " +
                                "source_uri: {type: 'uri', value: item.uri} " +
                            "} " +
                        "} " +
                    "});"
        ]
        
        let displayName = "apiTaskName"
        
        api.apiTask.create(params)
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                return self.api.apiTask.read(id)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                let params : ValidParams = [
                    "displayName" : displayName
                ]
                
                return self.api.apiTask.update(id, params: params)
            }
            .then { json -> FTStream in
                
                guard let id = json["body"]["id"].string else {
                    throw Error.ResourseIdMissing
                }
                
                guard let newDisplayName = json["body"]["displayName"].string else {
                    throw Error.BodyParamIsMissing("displayName")
                }
                
                XCTAssertEqual(displayName, newDisplayName)

                return self.api.apiTask.delete(id)
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
