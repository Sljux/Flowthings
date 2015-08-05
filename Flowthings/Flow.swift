//
//  Flow.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Flow {
    
    init(){}
    
    init(path: String){
        self.path = path
    }
    
    var id : String?
    var filter : String?
    var path : String?
    var description : String?
    var capacity : Int?
    
    func create(model: [String:AnyObject], success: (body: JSON?)->(), failure: (error:ErrorType)->())  {
        
        API.POST("/flow/", parameters: model,
            success: {
                json in
                success(body: json)
            },
            failure: {
                error in
                failure(error: error)
        })
        
    }
    
    func simulate(){}
    func read(){}
    func find(){}
    func update(){}
    func delete(){}
    
}