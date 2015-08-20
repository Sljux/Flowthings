//
//  Checks.swift
//  Flowthings
//
//  Created by Ceco on 8/12/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

public class Checks {

    //top level strings
    public var run : ValidChecks = ValidChecks()
    
    //AnyObject checks
    public var runDeep : ValidChecks = ValidChecks()

    //presets for common keys
    var runStandard : ValidChecks?
    
    
    var params : [String] {
        return run.keys.array
    }


    init(standardChecks: ValidChecks){
        runStandard = standardChecks
    }
    

    convenience init(){
        self.init(standardChecks: StandardChecks().run)
    }

    init (param: String, tests: ValidTests,
        standardChecks: ValidChecks){
        
        let index : String = param
        self.run[index] = ValidTests()
        self.run[index]? = tests
        self.runStandard = standardChecks
        
    }

    convenience init (param: String, tests: ValidTests){
        
        self.init(param: param,
            tests: tests,
            standardChecks: StandardChecks().run)
        
    }
    
    init (param: String, test: ValidTest){
        
        let index : String = param
        self.run[index] = ValidTests()
        self.run[index]? = [test]
        
        self.runStandard = StandardChecks().run
        
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