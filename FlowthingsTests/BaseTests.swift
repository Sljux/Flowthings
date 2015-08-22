
//
//  Base.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings
import SwiftyJSON

struct TestResult {
    
    var name: String = "Name not set"
    var desc: String = "Description Not Set"
    var fhash: String = "fhash not set"
    var testSet: String?
    var failOn: String?
}

class BaseTests : XCTestCase {
    
    var result = TestResult()
    
    override func setUp() {
        super.setUp()

        result.name = "Name not set"
        result.desc = "Description Not Set"
        result.fhash = "fhash not set"
    }
    
    let api = FlowthingsAPI(accountID: conf.accountID, tokenID: conf.tokenID)

    //Shorthands
    func fail(reason: String){
        self.result.failOn = reason
        self.reportResults(false)
        XCTFail(reason)
    }
    
    func pass(){
        reportResults(true)
    }
    
    func reportResults(pass: Bool) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let date = NSDate()
        
        let dateString : String = dateFormatter.stringFromDate(date)
        
        var params : ValidParams = [:]
        
        params["name"] = result.name
        params["fhash"] = result.fhash
        
        
        var elems : ValidParams = [
                "name" : result.name,
                "pass" : pass,
                "description" : result.desc,
                "local time" : dateString
                ]
        
        if let failOn = result.failOn {
            elems["failed on"] = failOn
        }

        if let testSet = result.testSet {
            elems["test set"] = testSet
        }
        else{
            elems["test set"] = String(self.dynamicType)
        }
        
        params["elems"] = elems
        
        api.drop.createOnFlowID(
            flowID: conf.unitTestsFlowID,
            params: params,
            success: {
            json in
                //Nothing here
            },
            failure: {
                error in
                print(error)
                XCTFail("Could not report to flowthings")
        })
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}