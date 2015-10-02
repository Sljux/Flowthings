//
//  Token.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Token : FTCreate, FTRead, FTDelete {
    
    public var baseURL = "/token/"
    public var createRequiredParams : [String] = ["paths"]
    
}