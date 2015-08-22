//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftyJSON

public class Drop : Base {
    
    override var baseURL : String { return "/drop/" }
    
    public func createOnFlowID(
        flowID flowID: String,
        params: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            let path = baseURL + flowID
            
            FTAPI.request(.POST, path: path, params: params,
                success: {
                    json in
                    
                    //Verify that ID came back
                    guard let _ = json!["body"]["id"].string else {
                        failure(error: .UnexpectedJSONFormat(json))
                        return
                    }
                    
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
    func aggregate(
        path: String,
        model: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->()){
            
            FTAPI.request(.PUT, path: path, params: model,
                success: {
                    json in
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
    
}



