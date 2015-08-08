//
//  Base.swift
//  Flowthings
//
//  Created by Ceco on 8/8/15.
//  Copyright © 2015 cityos. All rights reserved.
//

//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import Alamofire

public class Base {
    
    var baseURL : String { return "/base/" }
    
    init(){}
    
    public func create(
        model model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            //Check that path is set as we dont have flowID here
            guard let _ = model["path"] else {
                failure(error: .MissingPath)
                return
            }
            
            let path = baseURL
            
            FTAPI.request(.POST, path: path, parameters: model,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    public func read(
        path: String,
        success: (body: JSON)->(),
        failure: (error: FTAPIError)->()){
        
        FTAPI.request(.GET, path: path,
            success: {
                json in
                success(body: json!)
            },
            failure: {
                error in
                failure(error: error)
        })
    }
        
    func find(){}
    func multiFind(){}
    func update(){}
    func memberUpdate(){}
    func delete(){}
    func aggregate(){}
    
}

