//
//  Device.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Device : FTCreate, FTRead, FTUpdate, FTDelete, FTFind {
    
    public var baseURL = "/device/"
    public var createRequiredParams = ["path"]
    
}