//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Drop: FTRead, FTCreate {
    
    public var baseURL = "/drop/"
    
}

/** Drop Specific Methods */
extension Drop {
    
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



