//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Drop: FTRead, FTCreate {
    
    public init(){
    
        assert(!baseURL.isEmpty, "empty baseURL - please set it")
        
    }
    
    public var baseURL = "/drop/"

}

/** Drop Specific Methods */
extension Drop {
    
    /**
    Alternative Drop Create using flow_id instead of path
    
    - parameter flowID:  flow_id (from flowthings.io)
    - parameter params:  ValidParams
    - parameter success: closure
    - parameter failure: closure
    */
//    public func createOnFlowID(
//        flowID flowID: String,
//        params: [String:AnyObject],
//        success: (json: JSON)->(),
//        failure: (error: FTAPIError)->())  {
//            
//            let path = baseURL + flowID
//            
//            FTAPI.request(.POST, path: path, params: params,
//                success: {
//                    json in
//                    
//                    //Verify that ID came back
//                    guard let _ = json["body"]["id"].string else {
//                        failure(error: .UnexpectedJSONFormat(json: json))
//                        return
//                    }
//                    
//                    success(json: json)
//                },
//                failure: {
//                    error in
//                    failure(error: error)
//            })
//    }
    
    func aggregate(path: String, params: ValidParams){
            
            FTAPI.request(.PUT, path: path, params: params)
    }
    
}



