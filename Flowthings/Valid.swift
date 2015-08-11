//
//  Validate.swift
//  Flowthings
//
//  Created by Ceco on 8/9/15.
//  Copyright © 2015 cityos. All rights reserved.
//

typealias ValidTest = () -> Void

enum ValidReturn{

    case Success
    case Failure(messages: [String])
    
}

public class Valid : NSObject {
    
    public var isValid : Bool = true
    
    public var isFatal : Bool = false

    var messages : [String] = []

    var params : [String:AnyObject] = [:]
    var checkFor : [String] = []
    
    public var tests : [String:() -> Void] = [:]
    var _testsLoaded : Bool = false
    
    var ceco : Int {
        return 1
    }
    
    public func getMessages() -> [String] {
    
        return messages
    
    }

    public func addMessage(message: String) {
        
        messages.append(message)
        
    }
    
    public func loadTests () {
        
        //For non init calls
        guard !_testsLoaded else { return }
        
        let mirror = Mirror(reflecting: self)
        for (n, t) in mirror.children {
            print(n)
            print(t)
            if let name = n,
                test = t as? ValidTest {
                    tests[name] = test
            }
        }
        _testsLoaded = true
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

    
    public override init (){}
    
    public init(params:[String:AnyObject], checkFor: [String]) {
    
        super.init()
        self.checkFor = checkFor
        self.params = params

        if !checkRequired { return }
        
        loadTests()
        check()
    
    }
    
    func check() {

        //Make sure params are set if using empty init
        if !checkRequired { return }
        
        var missing = false
        
        for check in self.checkFor {
            missing = params[check] == nil
            if missing {
                messages.append(check + " is missing")
                isValid = false
            }
            else {
                print(tests)
                //extraTest = convertProperties[]

                if let test = tests[check] {
                    print("here")
                    let _ = test()
                }
            }
        }
    }
}

extension Valid {

    var flow_id : Int {
        print("flow_id checking hard")
        isValid = false
        return 1
    }
}