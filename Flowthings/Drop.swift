//
//  Drop.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public class Drop: FTCreate {
    
    public var baseURL = "/drop/"
    public var createRequiredParams = ["elems", "path"]
    
}

extension Drop {

    public func create(byFlowId flowID: String, params: ValidParams) -> FTStream  {
            
        let path = baseURL + flowID
            
        let valid = Valid(checkFor: ["elems"], params: params)
        valid.check("flow_id", value: flowID)
        
        return valid.stream  {
            FTAPI.request(.POST, path: path, params: params)
        }
    }
    
    public func read(flowId: String, id: String) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        valid.check("flow_id", value: flowId)
        
        let path = self.baseURL + "\(flowId)/\(id)"
        
        return valid.stream  {
            FTAPI.request(.GET, path: path)
        }
    }
    
    public func find(flowId: String, params: ValidParams) -> FTStream {
        
        let path = self.baseURL + flowId
        return FTAPI.request(.GET, path: path, params: params)
    }
    
    public func update(flowId: String, id: String, params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["elems"], params: params)
        
        let path = self.baseURL + "\(flowId)/\(id)"
        
        return valid.stream {
            FTAPI.request(.PUT, path: path, params: params)
        }
    }
    
    public func delete(flowId: String, id: String) -> FTStream {
        
        let valid = Valid()
        valid.check("id", value: id)
        valid.check("flow_id", value: flowId)
        
        let path = self.baseURL + "\(flowId)/\(id)"
        
        return valid.stream  {
            FTAPI.request(.DELETE, path: path)
        }
    }
    
    public func aggregate(flowID: String, params: ValidParams) -> FTStream {
        
        let valid = Valid(checkFor: ["groupBy", "output"], params: params)
        valid.check("flow_id", value: flowID)
        
        let path = baseURL + "\(flowID)/aggregate"
        
        return valid.stream  {
            FTAPI.request(.POST, path: path, params: params)
        }
    }
    
}



