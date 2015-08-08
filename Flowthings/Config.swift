//
//  Config.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

struct Config {
    
    init(accountID: String, tokenID: String){
        Config.accountID = accountID
        Config.tokenID = tokenID
    }
    
    static var accountID: String? = ""
    static var tokenID: String? = ""

    static let domain = "api.flowthings.io"
    static let apiVersion = "v0.1"
    static let secure = true

    
    static func url(path: String) -> NSURL? {
        
        guard   let accountID = Config.accountID,
                let _ = Config.tokenID else {
            print("Set creds first with Creds(accountID, tokenID)")
            return nil
        }
        var url = "http"

        if Config.secure {
            url += "s"
        }
        
        url += "://" + Config.domain + "/"
        url += Config.apiVersion + "/" + accountID
        
        //fix helper in case path is not starting with /
        if "/" != path.characters.first! {
            url += "/"
        }
        
        url += path
        
        guard let urlr = NSURL(string: url) else {
            return nil
        }
        
        return urlr
        
    }
}
