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

class APIDropCreateTests: BaseTests {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        result.testSet = "API Drop Create Set"
        result.name = "API Drop Create Test"
        result.desc = "One of the API Drop Create Test, description not set yet"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}