//
//  ApiTask.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public class ApiTask : FTCreate, FTRead, FTUpdate, FTDelete {
    
    public var baseURL = "/api-task/"
    public var createRequiredParams = ["destination", "js"]
    
}