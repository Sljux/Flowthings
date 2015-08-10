//
//  Validate.swift
//  Flowthings
//
//  Created by Ceco on 8/9/15.
//  Copyright © 2015 cityos. All rights reserved.
//

enum ValidReturn{

    case Success
    case Failure(messages: [String])
    
}

class Valid {

    var isValid : Bool = true
    var params : [String:AnyObject] = [:]
    var checkFor : [String] = []
    var messages : [String] = []
    
    var checks : [String:() -> Void] = [
        "flow_id": {
            return true
        }
    ]
    
    private var checkRequired : Bool {
        
        if params.count == 0 {
            messages.append("EMPTY params")
            isValid = false
        }
        
        if checkFor.count == 0 {
            messages.append("Empty checkFor list")
            //Send message - but might be valid if check automaticly build
            //isValid = false
        }
        
        return isValid
    }

    
    init (){}
    
    init(params:[String:AnyObject], checkFor: [String]) {
    
        self.checkFor = checkFor
        self.params = params

        if !checkRequired { return }
        
        
    }
    
    func check() {

        //Make sure params are set if using empty init
        if !checkRequired { return }
        
        var ok = false
        for check in self.checkFor {
            ok = params[check] == nil
            if ok { isValid = false }
        }
    }
    
}