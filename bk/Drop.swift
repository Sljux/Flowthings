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

public struct Drop {
    
    var path : String?
    //The path of the Flow where the Drop is to be written, optional if the flowId is provided in the url of the POST.
    
    var flowID : String?
    //Flow ID is used as alternative to path variable
    
    var location:CLLocation?
    //A location for the Drop converted into CLLocationCoordinate2D for ease of use within swift code
    
    var elems : JSON?
    //A map of data elements for the Drop. Values in the map may be of any data type that flowthings.io supports. If the type is not one that JSON supports, it must be supplied. See data_types for a list of types which must be specified in a {type:..., value:...} mapping.

    var fhash : String?
    //Unique Drop hash value. System generated if Drop is created with fhash as a top-level property. See https://flowthings.io/docs/flow-fhash for further information.
    
    init(){
        //
    }
    
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
                
                self.location = CLLocation (latitude: lat, longitude: lon)
                
        }
        
        //See if anything better can be done with this
        if json["elems"] != nil {
            self.elems = json["elems"]
        }
        
        if let lat = self.elems?["latitude"]["value"].double,
            let lon = self.elems?["longitude"]["value"].double {
                //print(lat, lon)
                self.location = CLLocation(latitude: lat, longitude: lon)
        }
        
    }

    static func jsonToDrop(jsonDrop: JSON) -> Drop? {
            
        var drop : Drop = Drop()
        
        if let path = jsonDrop["path"].string {
            drop.path = path
        }
        
        if let lat = jsonDrop["location"]["lat"].double,
            let lon = jsonDrop["location"]["lon"].double {
    
            drop.location = CLLocation (latitude: lat, longitude: lon)
        
        }
        
        //See if anything better can be done with this
        if jsonDrop["elems"] != nil {
            drop.elems = jsonDrop["elems"]
        }
        
        if let lat = drop.elems?["latitude"]["value"].double,
            let lon = drop.elems?["longitude"]["value"].double {
                drop.location = CLLocation(latitude: lat, longitude: lon)
        }
        
        return drop
    }
    
    public func create(flowID: String, setLocation: Bool, success:(drop: Drop) -> (), failure:(message: String) -> ()){
    
        if setLocation == true {
            var loc = Location()
            loc.setCurent()
        }
        //Flowthings.POST()
    }
    
}