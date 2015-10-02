//
//  Group.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/27/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Group : FTCreate, FTRead, FTUpdate, FTDelete, FTFind {
    
    public var baseURL = "/group/"
    public var createRequiredParams = ["memberIds"]
    
}