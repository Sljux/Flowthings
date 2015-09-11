//
//  Dev.swift
//  Flowthings
//
//  Created by Ceco on 8/11/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation


func q(args:AnyObject...) {

    for arg: AnyObject in args {
        print(arg)
    }
}


func caller(){
    let sourceString = NSThread.callStackSymbols()[1]

    var strings : [String] = sourceString.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: " -[]+?.,"))
    
    strings = strings.filter() { $0 != "" }
    
    print("Stack = " + strings[0])
    print("Framework = " + strings[1])
    print("Memory address = " + strings[2])
    print("Class caller = " + strings[3])
    print("Function caller = " + strings[4])
    print(sourceString, strings)
    
    let stringArray = strings[3].componentsSeparatedByCharactersInSet(
        NSCharacterSet.decimalDigitCharacterSet())
    let newClasscaller = NSArray(array: stringArray).componentsJoinedByString(" ")
    
    print(newClasscaller)
}
