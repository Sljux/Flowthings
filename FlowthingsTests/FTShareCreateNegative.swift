//
//  FTShareCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 05/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTShareCreate {
    
    func testShareCreateNoPaths_negative() {
        
        let expectation = expectationWithDescription("Calling share.create")
        
        let params : ValidParams = [
            "issuedTo" : "i550445140cf21961de8c1f46"
        ]
        
        api.share.create(params)
            .then { json -> () in
                
                XCTFail("Created Share with no paths")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testShareCreateNoIssuedTo_negative() {
        
        let expectation = expectationWithDescription("Calling share.create")
        
        let params : ValidParams = [
            "paths" : [
                "/ceco/framework/unit-tests/dump" : [
                    "dropRead": true,
                    "dropWrite": false
                ]
            ]
        ]
        
        api.share.create(params)
            .then { json -> () in
                
                XCTFail("Created Share with no issuedTo")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testShareCreateInvalidPaths_negative() {
        
        let expectation = expectationWithDescription("Calling share.create")
        
        let params : ValidParams = [
            "paths" : "badPathsTest",
            "issuedTo" : "i550445140cf21961de8c1f46"
        ]
        
        api.share.create(params)
            .then { json -> () in
                
                XCTFail("Created Share with invalid paths")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testShareCreateInvalidIssuedTo_negative() {
        
        let expectation = expectationWithDescription("Calling share.create")
        
        let params : ValidParams = [
            "paths" : [
                "/ceco/framework/unit-tests/dump" : [
                    "dropRead": true,
                    "dropWrite": false
                ]
            ],
            "issuedTo" : "badIdentityTest"
        ]
        
        api.share.create(params)
            .then { json -> () in
                
                XCTFail("Created Share with bad issuedTo")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func testShareCreateSelf_negative() {
        
        let expectation = expectationWithDescription("Calling share.create")
        
        var params : ValidParams = [
            "paths" : [
                "/ceco/framework/unit-tests/dump" : [
                    "dropRead": true,
                    "dropWrite": false
                ]
            ]
        ]
        
        api.identity.read()
            .then { json -> FTStream in
                
                guard let body = json["body"].array as? [ValidParams] else {
                    throw Error.BodyIsMissing
                }
                
                guard let id = body[0]["id"] as? String else {
                    throw Error.ResourseIdMissing
                }
                
                params["issuedTo"] = id
                
                return self.api.share.create(params)
        	}
            .then { json -> () in
                
                XCTFail("Shared to yourself")
                expectation.fulfill()
            }
            .error { error in
                
                expectation.fulfill()
        	}
        
        waitForExpectationsWithTimeout(conf.timeout) { error in
            
            if let error = error {
                print(error)
            }
        }
    }
    
}