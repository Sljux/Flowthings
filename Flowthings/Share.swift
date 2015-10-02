//
//  Share.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/29/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Share : FTCreate, FTRead, FTDelete {
    
    public var baseURL : String = "/share/"
    public var createRequiredParams : [String] = ["paths", "issuedTo"]
    
}