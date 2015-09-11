
//
//  Base.swift
//  Flowthings
//
//  Created by Ceco on 8/22/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

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
    
    let api = FTAPI(accountID: conf.accountID, tokenID: conf.tokenID)

    //Shorthands
    func report(reason: String) -> String {
        self.result.failOn = reason
        self.reportResults(false)
        return reason
    }

    func report(valid: Valid) -> Bool {
        
        if valid.isValid { return true }

        var reason = ""
        var comma = ""
        for message in valid.getMessages(){
            reason += comma
            reason += message
            comma = ", "
        }
        
        self.result.failOn = reason
        self.reportResults(false)
        return false
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
        
        api.drop.createOnFlowID(conf.unitTestsFlowID, params: params)
            .success {
            json in
                print("test reported")
            }
            .failure {
                error in
                print(error)
                XCTFail("Could not report to flowthings")
        }
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}


class TestLast : XCTestCase {
    
    func testNothing(){}
    
}