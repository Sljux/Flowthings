//
//  RSS.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public class RSS : FTCreate, FTRead, FTUpdate, FTDelete {
    
    public var baseURL = "/rss/"
    public var createRequiredParams = ["destination", "url"]
    
}