//
//  FTFlowCreatePositive.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

extension FTApiTaskCreate {
    
    func testApiTaskCreateNoDestination_negative() {
        
        let expectation = expectationWithDescription("Calling apiTask.create")
        
        let params : ValidParams = [
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
        
        api.apiTask.create(params)
            .then { json -> () in
                
                XCTFail("Created ApiTask with no destination")
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

    func testApiTaskCreateEmptyDestination_negative() {
        
        let expectation = expectationWithDescription("Calling apiTask.create")
        
        let params : ValidParams = [
            "destination" : "",
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
        
        api.apiTask.create(params)
            .then { json -> () in
                
                XCTFail("Created ApiTask with empty destination")
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
    
    func testApiTaskCreateInvalidPath_negative() {
        
        let expectation = expectationWithDescription("Calling apiTask.create")
        
        let params : ValidParams = [
            "destination" : "badPathTest",
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
        
        api.apiTask.create(params)
            .then { json -> () in
                
                XCTFail("Created ApiTask with invalid destination")
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
    
    func testApiTaskCreateNoJS_negative() {
        
        let expectation = expectationWithDescription("Calling apiTask.create")
        
        let params : ValidParams = [
            "destination" : conf.flowPath
        ]
        
        api.apiTask.create(params)
            .then { json -> () in
                
                XCTFail("Created ApiTask with no js")
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
