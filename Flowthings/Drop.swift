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


public struct Drop {

    enum DropErrors {
        case BadConnection
    
    }
    
    var path : String?
    //The path of the Flow where the Drop is to be written, optional if the flowId is provided in the url of the POST.
    
    var flowID : String?
    //Flow ID is used as alternative to path variable
    
    var location:Location = Location()
    //A location for the Drop converted into CLLocationCoordinate2D for ease of use within swift code
    
    var elems : JSON?
    //A map of data elements for the Drop. Values in the map may be of any data type that flowthings.io supports. If the type is not one that JSON supports, it must be supplied. See data_types for a list of types which must be specified in a {type:..., value:...} mapping.
    
    var fhash : String?
    //Unique Drop hash value. System generated if Drop is created with fhash as a top-level property. See https://flowthings.io/docs/flow-fhash for further information.
    
    enum DropError: ErrorType {
        case PathNotSet
        case CredsNotSet
    }
    
    init(){}
    
    init(fromFlowID flowID: String){
        self.flowID = flowID
    }
    
    init(fromPath path: String){
        self.path = path
    }
    
    init(fromJson json: JSON) {
        
        if let path = json["path"].string {
            self.path = path
        }
        
        if let lat = json["location"]["lat"].double,
            let lon = json["location"]["lon"].double {
                
                self.location = Location (latitude: lat, longitude: lon)
                
        }
        
        //See if anything better can be done with this
        if json["elems"] != nil {
            self.elems = json["elems"]
        }
        
        if let lat = self.elems?["latitude"]["value"].double,
            let lon = self.elems?["longitude"]["value"].double {
                //print(lat, lon)
                self.location = Location(latitude: lat, longitude: lon)
        }
        
    }
    
    func create(model: [String:AnyObject],
        success: (result: Result<AnyObject>)->(),
        failure: (result: Result<AnyObject>)->())  {
        
//        API.POST("/drop/", parameters: model,
//            success: {
//                result in
//                success(result: result)
//            },
//            failure: {
//                result in
//                failure(result: result)
//        })
        
    }
    
    public func read(flowID flowID: String, dropID: String, success: (body: JSON?)->()?, failure: (error: ErrorType?)->()?){
        
//        let path = "/drop/" + flowID + "/" + dropID
//        let parameters : [String:AnyObject] = [:]
//        
//        API.GET(path,
//            parameters: parameters,
//            success: {
//                json_option in
//                print(json_option)
//                if let json = json_option {
//                    success(body: json)
//                }
//                return nil
//            },
//            failure: {
//            error in
//                failure(error: nil)
//                return nil
//        })
    }
    
    func find(){}
    func multiFind(){}
    func update(){}
    func memberUpdate(){}
    func delete(){}
    func aggregate(){}
    
}