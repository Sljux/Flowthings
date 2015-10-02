//
//  Config.swift
//  Flowthings
//
//  Created by Ceco on 8/7/15.
//  Copyright © 2015 cityos. All rights reserved.
//

struct Config {
    
    static var accountID: String? = ""
    static var tokenID: String? = ""
    
    static let domain = "flowthings.io"
    static let apiVersion = "v0.1"
    static let secure = true
    
    /**
    Set these once per app run
    
    - returns: Config object or kicks off assert 
    */
    init() {
    
        //.gitignore hides Config.plist - to avoid commiting tokens
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                if let accountID = config["accountID"] as? String,
                    let tokenID = config["tokenID"] as? String {
                        Config.accountID = accountID
                        Config.tokenID = tokenID
                        return
                }
            }
        }

        assert(false, "Config.plist has to have accountID and tokenID for this init to work")
    }

    init(accountID: String, tokenID: String) {
        Config.accountID = accountID
        Config.tokenID = tokenID
    }

    static func url(path: String, type: URLType = .API) -> NSURL? {
        
        guard let accountID = Config.accountID,
            let _ = Config.tokenID else {
                print("Set creds first with Creds(accountID, tokenID)")
                return nil
        }
        var url = "http"
        
        if Config.secure {
            url += "s"
        }
        
        url += "://" + type.rawValue + "." + Config.domain
        
        if type == .API {
	        url += "/" + Config.apiVersion + "/" + accountID
        }
        
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