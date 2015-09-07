//
//  FTCreate.swift
//  Flowthings
//
//  Created by Ceco on 8/26/15.
//  Copyright © 2015 cityos. All rights reserved.
//


struct Checks_Plus_Additional {
    
    func create(params params: ValidParams) -> FTStream {
        
        let checks = Checks(param: "path",
            test: {
                valid, path in
                
                guard let p = path as? CheckString else {
                    return valid.addError("param: 'path' is not a String")
                }
                
                if p.isShorterThen(3){
                    return valid.addError("path: \"" + p + "\" is too short")
                }
        })
        
        let extra_test : ValidTest = {
            valid, elems in
            
            guard let e = elems as? ValidParams else {
                return valid.addError("elems are not of type FlowParams alias: [String:AnyObject]")
            }
            
            
            let json = JSON(e)
            
            guard json.count > 0 else {
                return valid.addError("Sending empty elems")
            }
        }
        
        checks.add("elems", test: extra_test)
        
        let check = Valid(checks: checks, params: params)
    
        if check.isValid  {
            return FTAPI.request(.POST, path: "somePath", params: params)
        }
        
        return FTStream { _, _, reject, _ in
            reject(.BadParams(messages: check.messages)) }
    }
}