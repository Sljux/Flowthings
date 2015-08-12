//
//  Validate.swift
//  Flowthings
//
//  Created by Ceco on 8/9/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public typealias ValidTest = ((Valid, String) -> Void)
public typealias ValidTests = [ValidTest]
public typealias ValidChecks = [String:ValidTests]

protocol ValidChecksProtocol {

    var checks : ValidChecks { get }
    
}

protocol ValidResultsProtocol {
    
    func validationSuccess()
    func validationFail()
    
}


public class Valid {
    
    public var isValid : Bool = true
    
    public var isFatal : Bool = false

    var messages : [String] = []

    var checks : Checks?
    var params : [String:AnyObject] = [:]
    var checkFor : [String] = []
    
    public var tests : [String:[() -> ()]] = [:]
    
    public func getMessages() -> [String] {
    
        return messages
    
    }

    public func addMessage(message: String) {
        
        messages.append(message)
        
    }
    
    private var checkRequired : Bool {
        
        if params.count <= 0 {
            messages.append("EMPTY params")
            isValid = false
        }
        
        if checkFor.count <= 0 {
            messages.append("Empty checkFor list - check in code for .count")
            //Send message - but might be invalid, if check automatic
            //isValid = false
        }
        
        return isValid
    }
    
    public init (){}
    
    public init(checks: Checks, params:[String:AnyObject]) {
    
        self.checkFor = checks.params
        self.params = params
        self.checks = checks

        if !checkRequired { return }
        
        check()
    
    }
    
    func check() {

        //Make sure params are set if using empty init
        if !checkRequired { return }
        
        for check in checkFor {
            if params[check] == nil {
                messages.append(check + " is missing")
                isValid = false
            }
            else {
                
                //Run all sub tests
                if let tests = checks?.run[check] {
                    for test in tests {
                        if let value = params[check] as? String {
                            test(self, value)
                        }
                        else {
                            //Implement alternative test for Dict
                            print("AnyObject test - can not test this yet")
                        }
                    }
                }
            }
        }
    }
}