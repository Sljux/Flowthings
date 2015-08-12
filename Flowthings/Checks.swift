//
//  Checks.swift
//  Flowthings
//
//  Created by Ceco on 8/12/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

public struct Checks {

    public var run : ValidChecks = [
        "flow_id":ValidTests(),
        "drop_id":ValidTests()
    ]
    
    mutating public func add(param: String, test: ValidTest){
        
        if run[param] == nil {
            run[param] = []
        }
        
        run[param]?.append(test)
    }
 
    subscript(index: String) -> ValidTests? {
        get {
            var result : ValidTests? = nil
            if let tests = run[index] {
                if tests.count > 0 {
                    result = tests
                }
            }
            return result

        }
        set(newValue) {
            if let tests = newValue {
                for test in tests {
                    add(index, test: test)
                }
            }
            else {
                //reset
                run = ValidChecks()
            }
        }
    }
}