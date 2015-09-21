//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Drop: FTRead {
    
    public var baseURL = "/drop/"
    
}

/** Drop Specific Methods */
extension Drop {
    
    
    /**
    
    flowthings.io api.<service>.create method
    
    - parameter params:     ValidParams is typealias for [String:AnyObject], JSON standard swift format, has to have valid path and elems 
    
    elems
    A map of data elements for the Drop. Values in the map may be of any data type that flowthings.io supports. If the type is not one that JSON supports, it must be supplied. See Drop Data Types for a list of types which must be specified in a {type:..., value:...} mapping.
    
    path
    The path of the Flow where the Drop is to be written
    
    Optional:
    
    location
    A location for the Drop. For more on specification options, see Location Data.
    
    fhash
    Unique Drop hash value. System generated if Drop is created with fhash as a top-level property. See FHashes for further information.

    
    - returns: FTStream
    */
    public func create(params params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["path", "elems"], params: params)
        
        return valid.stream  {
            FTAPI.request(.POST, path: self.baseURL, params: params)
        }
        
    }

    /**
    Alternative Drop Create using flow_id instead of path
    
    - parameter flowID:  flow_id (from flowthings.io)
    - parameter params:  ValidParams
    
    - returns: FTStream
    */
    public func createOnFlowID(flowID: String, params: ValidParams) -> FTStream  {
            
        let path = baseURL + flowID
            
        let valid = Valid(checkFor: ["elems"], params: params)
        
        //Check inline
        valid.check("flow_id", value: flowID)
        
        return valid.stream  {
            FTAPI.request(.POST, path: path, params: params)
        }
    }
    
    /**
    # HTTP Drop Aggregation
    
    Drop data within a single Flow can be grouped and aggregated in powerful ways.
    
    For example:
    
    Get the average wind speed in the last 10 minutes, by town
    Get the maximum temperature within 5 miles of New York City
    Get the percentage of sensors that are currently online

    ## Required Params:
    
    ### groupBy
      A list of the fields by which you'd like the results grouped. Results can be grouped by any literal element within a Drop
    ### output
        The fields you want to output in your query
    
    ## Optional Params:
    
    ### filter
      Filter will only include the Drops whose data you're interested in aggregating
    
    ### rules
      Takes boolean expressions and returns a list of booleans expressed as 0s and 1s for which drops returned true or false
    
    ### sorts
      The order in which the results are returned

    
    - parameter flowID:   flow_id : String
    - parameter params:   ValidParams : [Sting:AnyObject]
    
    - returns: FTStream
    */
    func aggregate(flowID: String, params: ValidParams) -> FTStream {
        
        let path = baseURL + "/" + flowID + "/aggregate"

        let valid = Valid(checkFor: ["groupBy", "output"], params: params)
        
        valid.check("flow_id", value: flowID)
        
        return valid.stream  {
            FTAPI.request(.PUT, path: path, params: params)
        }
    }
    
}



