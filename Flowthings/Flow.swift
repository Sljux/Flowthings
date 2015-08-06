//
//  Flow.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

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
    
    func create(model: [String:AnyObject], success: (result: Result<AnyObject>)->(), failure: (result:Result<AnyObject>)->())  {
        
//        API.POST("/flow/", parameters: model,
//            success: {
//                result in
//                success(result: result)
//            },
//            failure: {
//                result in
//                failure(result: result)
//        })
        
    }
    
    func simulate(){}
    func read(){}
    func find(){}
    func update(){}
    func delete(){}
    
}