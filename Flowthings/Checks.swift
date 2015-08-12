//
//  Checks.swift
//  Flowthings
//
//  Created by Ceco on 8/12/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

public class Checks {

    public var run : ValidChecks = ValidChecks()

    public var runDeep : ValidChecks = ValidChecks()

    var params : [String] {
        return run.keys.array
    }

    init(){}
    
    init (param: String, tests: ValidTests){

        let index : String = param
        self.run[index] = ValidTests()
        self.run[index]? = tests
        
    }

    init (param: String, test: ValidTest){
        
        let index : String = param
        self.run[index] = ValidTests()
        self.run[index]? = [test]
        
    }

    
    public func add(param: String, test: ValidTest){
        
        if run[param] == nil {
            run[param] = []
        }
        
        run[param]?.append(test)
    }

    public func add(param: String, tests: ValidTests){
        
        if run[param] == nil {
            run[param] = []
        }
        
        for test in tests {
            run[param]?.append(test)
        }
    }
}