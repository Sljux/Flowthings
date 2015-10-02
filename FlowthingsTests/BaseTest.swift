//
//  BaseTest.swift
//  Flowthings
//
//  Created by Ceco on 01/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import XCTest
@testable import Flowthings

class BaseTest: XCTestCase {
    
    let api = FTAPI(accountID: conf.accountID, tokenID: conf.tokenID)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
