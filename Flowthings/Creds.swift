//
//  Creds.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/24/15.
//  Copyright © 2015 cityos. All rights reserved.
//

public struct Creds {
    
    let accountID : String?
    let tokenID : String?
    
    //temp during development
    init(){
        accountID = "ceco"
        tokenID = "6GMlrMISkC95NsTvadZKetBrgo4G0TKW"
    }
    
    init(accountID: String, tokenID: String){
        self.accountID = accountID
        self.tokenID = tokenID
    }
}
