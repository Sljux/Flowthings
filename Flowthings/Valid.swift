//
//  Validate.swift
//  Flowthings
//
//  Created by Ceco on 8/9/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public typealias ValidTest = ((Valid, AnyObject) -> Void)
public typealias ValidTests = [ValidTest]
public typealias ValidChecks = [String:ValidTests]

public typealias ValidParams = [String:AnyObject]

public protocol ValidChecksProtocol {
    
    var checks : ValidChecks { get }
    
}

public enum ValidResult {
    case onSuccess(json: JSON)
    case onFailure(error: FTAPIError)
    //case onCancel(error: FTAPIError)
}

public protocol ValidResultsProtocol {
    
    func validationSuccess()
    func validationFail()
    
}


public class Valid {
    
    public var isValid : Bool = true
    
    public var isFatal : Bool = false
    
    var messages : [String] = []
    
    var checks : Checks?
    var params : ValidParams = [:]
    var checkFor : [String] = []
    
    public var tests : [String:[() -> ()]] = [:]
    
    public convenience init (checkFor: [String], params:ValidParams){
        
        let checks = Checks(checkFor: checkFor)
        self.init(checks: checks, params: params)
        
    }
    
    public init (checkFor: [String:AnyObject]){
        
        let checks = Checks()
        self.checkFor = checks.params
        self.checks = checks
        
        for (param, value) in checkFor {
            check (param, value: value)
        }
    }

    public init (){
        let checks = Checks()
        self.checkFor = checks.params
        self.checks = checks
    }
    
    public init(checks: Checks, params:ValidParams) {
        
        self.checkFor = checks.params
        self.params = params
        self.checks = checks
        
        if !checkRequired { return }
        
        check()
        
    }
    
    public func getMessages() -> [String] {
        
        return messages
        
    }
    
    public func addMessage(message: String) {
        
        messages.append(message)
        
    }
    
    //Shortcut
    public func addError(message: String) {
        
        self.isValid = false
        self.messages.append(message)
        
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
    
    func check() {
        
        //Make sure params are set if using empty init
        if !checkRequired { return }
        
        for param in checkFor {
            
            if params[param] == nil {
                messages.append("Param: " + param + " is not provided")
                isValid = false
            }
            else {
                //Run standard added sub tests first
                if let tests = checks?.runStandard?[param] {
                    for test in tests {
                        if let value = params[param] as? CheckString {
                            test(self, value)
                        }
                        else if let value = params[param] {
                            //Any object test
                            test(self, value)
                        }
                    }
                }
                
                //Run manually added sub tests
                if let tests = checks?.run[param] {
                    for test in tests {
                        if let value = params[param] as? CheckString {
                            test(self, value)
                        }
                        else if let value = params[param] {
                            //Any object test
                            test(self, value)
                        }
                    }
                }
                
            }
        }
        
        //Additional standard checks
        for (param,_) in params {
            
            //Skip those we explicitly checked already
            if checkFor.contains(param) {
                continue
            }
            
            //Run standard added sub tests first
            if let tests = checks?.runStandard?[param] {
                for test in tests {
                    if let value = params[param] as? CheckString {
                        test(self, value)
                    }
                    else if let value = params[param] {
                        //Any object test
                        test(self, value)
                    }
                }
            }
            
            
        }
    }
    
    public func check(param: String, value: AnyObject){
        
        //Run standard added sub tests first
        if let tests = checks?.runStandard?[param] {
            for test in tests {
                if let value = value as? CheckString {
                    test(self, value)
                }
                else {
                    //Any object test
                    test(self, value)
                }
            }
        }
        
        //Run manually added sub tests
        if let tests = checks?.run[param] {
            for test in tests {
                if let value = value as? CheckString {
                    test(self, value)
                }
                else {
                    //Any object test
                    test(self, value)
                }
            }
        }
    }
    
    public func stream(action: ()->FTStream ) ->FTStream {
        
        if isValid  {
            return action()
        }
        
        return FTStream { _, _, reject, _ in
            reject(.BadParams(messages: self.messages)) }
    }
    
}