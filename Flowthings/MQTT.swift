//
//  MQTT.swift
//  Flowthings
//
//  Created by Ceco on 02/10/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

public class MQTT : FTCreate, FTRead, FTUpdate, FTDelete {
    
    public var baseURL = "/mqtt/"
    public var createRequiredParams = ["destination", "topic", "uri"]
    
}