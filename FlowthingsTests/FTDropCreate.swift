//
//  DropTests.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
import Flowthings

class FTDropCreateTests: BaseTests {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        result.testSet = "FTDrop Create Set"
        result.name = "FTDrop Create Test"
        result.desc = "FTDrop Create Test, description not set yet"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
